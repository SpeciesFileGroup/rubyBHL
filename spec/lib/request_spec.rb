require_relative '../spec_helper'
describe RubyBHL::Request do

  subject { RubyBHL::Request }

  describe 'instance' do
    it 'has a default FORMAT' do
      expect(RubyBHL::Request::FORMAT).to eq('json')
    end

    it 'uses API version 3' do
      expect(RubyBHL::Request::API_VERSION).to eq('api3')
    end

    it 'knows the API methods' do
      expect(RubyBHL::Request::METHODS.keys.count).to eq(16)
    end

    it 'has a base URL' do
      expect(RubyBHL::Request::BASE_URL).to eq('https://www.biodiversitylibrary.org')
    end

    it 'has a SEARCH_BASE' do
      expect(RubyBHL::Request::SEARCH_BASE).to eq('https://www.biodiversitylibrary.org/api3?')
    end

    describe 'search_url' do
      before(:each) {
        @r = RubyBHL::Request.new()
      }

      it 'can validate that "foo" is not a supported param for :NameSearch `params_are_supported?`' do
        @r.params = {'foo' => 'bar'}
        expect(@r.params_are_supported?).to be_falsey
      end

      it 'can validate that "name" is a supported param for :NameSearch `params_are_supported?`' do
        @r.params = {"name" => 'bar'}
        expect(@r.params_are_supported?).to be_truthy
      end

      it 'can validate that required params are not present with `has_required_params?`' do
        @r.params = {'foo' => 'bar'}
        expect(@r.has_required_params?).to be_falsey
      end

      it 'can validate that required params are present with `has_required_params?`' do
        @r.params = {'name' => 'bar'}
        expect(@r.has_required_params?).to be_truthy
      end

      it 'can be invalidated with `valid?`' do
        expect(@r.valid?).to be_falsey
      end

      it 'can be validated with `valid?`' do
        @r.params = {'name' => 'bar'}
        expect(@r.valid?).to be_truthy
      end

      it 'replaces spaces with plus in params' do
       @r.params = {'name' => 'Aus bus'}
       expect(@r.search_url =~ /\s/).to_not be_truthy
      end

    end

    describe 'API keys' do
      it "are stored in an `api_key` attribute" do
        expect(RubyBHL::Request.new()).to respond_to(:api_key)
      end

      it 'are required' do
        expect{RubyBHL::Request.new(api_key: nil)}.to raise_error RubyBHL::Error
      end

      it "can come from `ENV['BHL_API_KEY']`" do
        expect(RubyBHL::Request.new(api_key: RubyBHL::API_KEY_ENV).api_key).to eq('sekret_key_here')
      end

      it 'can come from `~/.bhl_api_key`' do
        if File.exists?(RubyBHL::API_KEY_FILE_PATH)
          expect(RubyBHL::Request.new()).to be_truthy
        else
          expect{RubyBHL::Request.new()}.to raise_error RubyBHL::Error, API_KEY_MESSAGE
        end
      end

      it "are from ~/.bhl_api_key instead of ENV['BHL_API_KEY'] when both provided" do
        if RubyBHL::API_KEY_FILE.nil? || RubyBHL::API_KEY_ENV.nil?
          pending API_KEY_MESSAGE
        else
          expect(RubyBHL::Request.new().api_key).to eq(RubyBHL::API_KEY_FILE )
        end
      end

      it "are from opts(:api_key) instead of ENV or ~/.bhl_api_key when provided" do
        if RubyBHL::API_KEY_FILE.nil? || RubyBHL::API_KEY_ENV.nil?
          pending API_KEY_MESSAGE
        else
          expect(RubyBHL::Request.new(api_key: 'foo').api_key).to eq('foo')
        end
      end

   end
  end

end

