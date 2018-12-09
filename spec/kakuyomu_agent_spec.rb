RSpec.describe KakuyomuAgent do
  let(:agent) { described_class.new(driver: Selenium::WebDriver.for(:chrome, options: options)) }
  let(:options) { Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]) }

  describe '#login!' do
    subject { agent.login!(email: email, password: password) }

    let(:email) { ENV.fetch('KAKUYOMU_EMAIL') }
    let(:password) { ENV.fetch('KAKUYOMU_PASSWORD') }

    it { is_expected.to be true }
  end

  describe '#create_episode and #delete_episode' do
    subject do
      episode_url = agent.create_episode(work_id: work_id, title: title, body: body, date: date)
      agent.delete_episode(work_id: work_id, episode_id: KakuyomuAgent::UrlHelper.extract_episode_id(episode_url))
    end

    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:title) { '投稿・削除テスト' }
    let(:body) { 'このエピソードが削除されていなければ、KakuyomuAgentの削除機能に問題が起きています。' }

    before do
      agent.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    context 'without date' do
      let(:date) { nil }

      it 'creates and deletes episode without errors' do
        expect { subject }.not_to raise_error
      end
    end

    context 'with future date' do
      let(:date) { Time.now + 24 * 60 * 60 }

      it 'creates and deletes reserved episode without errors' do
        expect { subject }.not_to raise_error
      end
    end
  end

  describe '#update_episode' do
    subject { agent.update_episode(work_id: work_id, episode_id: episode_id, title: title, body: body) }

    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:episode_id) { ENV.fetch('EPISODE_ID') }
    let(:title) { '編集テスト' }
    let(:body) { "このエピソードは、KakuyomuAgentによって#{Time.now.strftime('%Y年%m月%d日%H時%M分')}に編集されました。" }

    before do
      agent.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    it { expect { subject }.not_to raise_error }
  end
end
