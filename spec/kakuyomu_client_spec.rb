RSpec.describe KakuyomuClient do
  let(:client) { described_class.new }

  describe '#login!' do
    subject { client.login!(email: email, password: password) }

    let(:email) { ENV.fetch('KAKUYOMU_EMAIL') }
    let(:password) { ENV.fetch('KAKUYOMU_PASSWORD') }

    it { is_expected.to be true }
  end
end
