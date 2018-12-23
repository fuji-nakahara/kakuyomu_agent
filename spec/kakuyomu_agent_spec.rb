RSpec.describe KakuyomuAgent do
  let(:agent) { described_class.new }

  describe '#login!' do
    subject { agent.login!(email: email, password: password) }

    let(:email) { ENV.fetch('KAKUYOMU_EMAIL') }
    let(:password) { ENV.fetch('KAKUYOMU_PASSWORD') }

    it { is_expected.to be true }
  end

  describe '#create_episode and #delete_episode' do
    subject do
      episode_url = agent.create_episode(work_id: work_id, title: title, body: body)
      agent.delete_episode(work_id: work_id, episode_id: KakuyomuAgent::UrlHelper.extract_episode_id(episode_url))
    end

    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:title) { '投稿・削除テスト' }
    let(:body) { 'このエピソードが削除されていなければ、KakuyomuAgentの削除機能に問題が起きています。' }

    before do
      agent.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    it 'creates and deletes episode without errors' do
      expect { subject }.not_to raise_error
    end
  end

  describe '#update_episode' do
    subject { agent.update_episode(work_id: work_id, episode_id: episode_id, title: title, body: body) }

    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:episode_id) { ENV.fetch('EPISODE_ID') }
    let(:title) { '編集テスト' }
    let(:body) do
      <<~EOS
        機械の小説とは、機械について書かれた小説のことである。
        機械による小説とは、機械によって書かれた小説のことである。
        機械のための小説とは、機械の存続のために書かれた小説のことである。

        |機械《ソフトウェア》とは、KakuyomuAgentのことである。
      EOS
    end

    before do
      agent.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    it { expect { subject }.not_to raise_error }
  end

  describe '#create_episode and #update_episode with future date' do
    subject do
      episode_url = agent.create_episode(work_id: work_id, title: title, body: body, date: date)
      @episode_id = KakuyomuAgent::UrlHelper.extract_episode_id(episode_url)
      agent.update_episode(work_id: work_id, episode_id: @episode_id, title: title, body: body, date: date)
    end

    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:title) { '予約テスト' }
    let(:body) { 'このエピソードが削除されていなければ、KakuyomuAgentの削除機能に問題が起きています。' }
    let(:date) { Time.now + 60 * 60 * 24 }

    before do
      agent.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    after do
      agent.delete_episode(work_id: work_id, episode_id: @episode_id)
    end

    it 'creates and updates reserved episode without errors' do
      expect { subject }.not_to raise_error
    end
  end
end
