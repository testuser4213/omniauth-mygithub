require 'spec_helper'

describe OmniAuth::Strategies::MyGitHub do
  let(:github_site)           { 'https://api.github.com' }
  let(:github_authorize_url)  { 'https://github.com/login/oauth/authorize' }
  let(:github_token_url)      { 'https://github.com/login/oauth/access_token' }
  let(:access_token)          { double('AccessToken', options: {}) }
  let(:parsed)                { double('ParsedResponse') }
  let(:response)              { double('Response', parsed: parsed) }

  subject { OmniAuth::Strategies::MyGitHub.new({}) }
  before :each do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'has valid site' do
      expect(subject.options.client_options.site).to eq(github_site)
    end

    it 'has valid authorize_url' do
      expect(subject.options.client_options.authorize_url).to eq(github_authorize_url)
    end

    it 'has valid token_url' do
      expect(subject.options.client_options.token_url).to eq(github_token_url)
    end
  end

  context '#raw_info' do
    it 'should parse response' do
      expect(access_token).to receive(:get).with('user').and_return(response)
      expect(subject.raw_info).to eq(parsed)
    end
  end

  context '#emails' do
    it 'should return emails' do
      expect(access_token).to receive(:get).with('user/emails').and_return(response)
      expect(subject.emails).to eq(parsed)
    end
  end

  context '#primary_email' do
    let(:user_emails) do
      [
        { 'email' => 'user1@example.com' },
        { 'email' => 'user2@example.com', 'primary' => true, 'verified' => true },
        { 'email' => 'user3@example.com', 'verified'=> true }
      ]
    end
    let(:primary_email) { 'user2@example.com' }

    it 'should return primary email' do
      allow(subject).to receive(:emails).and_return(user_emails)
      expect(subject.primary_email).to eq(primary_email)
    end
  end
end
