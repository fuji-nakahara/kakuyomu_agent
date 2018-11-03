RSpec.describe KakuyomuClient do
  let(:client) { described_class.new }

  describe '#login!' do
    subject { client.login!(email: email, password: password) }

    let(:email) { ENV.fetch('KAKUYOMU_EMAIL') }
    let(:password) { ENV.fetch('KAKUYOMU_PASSWORD') }

    it { is_expected.to be true }
  end

  describe '#create_episode and #delete_episode' do
    let(:work_id) { ENV.fetch('WORK_ID') }
    let(:title) { '投稿テスト' }
    let(:body) { Time.now.to_s }

    before do
      client.login!(email: ENV.fetch('KAKUYOMU_EMAIL'), password: ENV.fetch('KAKUYOMU_PASSWORD'))
    end

    it 'creates and deletes episode without errors' do
      expect do
        episode_id = client.create_episode(work_id: work_id, title: title, body: body)
        client.delete_episode(work_id: work_id, episode_id: episode_id)
      end.not_to raise_error
    end
  end
end
