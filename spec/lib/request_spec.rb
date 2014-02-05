require_relative '../spec_helper'
describe RubyBHL::Request do

  subject { RubyBHL::Request }

  describe 'instance' do
    before(:each) {
      @r = RubyBHL::Request.new()
    }

    it 'has a default FORMAT' do
      expect(RubyBHL::Request::FORMAT).to eq('json')
    end

    it 'uses API version 2' do
      expect(RubyBHL::Request::API_VERSION).to eq('api2')
    end

    it 'uses the http interface' do
      expect(RubyBHL::Request::INTERFACE).to eq('httpquery.ashx?')
    end

    it 'knows the API methods' do
      expect(RubyBHL::Request::METHODS).to have(39).things
    end

    it 'has a base URL' do
      expect(RubyBHL::Request::BASE_URL).to eq('http://www.biodiversitylibrary.org')
    end

    it 'has a SEARCH_BASE' do
      expect(RubyBHL::Request::SEARCH_BASE).to eq('http://www.biodiversitylibrary.org/api2/httpquery.ashx?')
    end

    describe 'API key handling' do
      it "has an `api_key` attribute" do
        expect(@r).to respond_to(:api_key)
      end

      it "can use an API key from `ENV['BHL_API_KEY']`" do
        expect(RubyBHL::Request.new(api_key: RubyBHL::API_KEY_ENV).api_key).to eq('sekret_key_here')
      end

      it 'can use an API key from `~/.bhl_api_key`' do
        if File.exists?(RubyBHL::API_KEY_FILE_PATH)
          expect(RubyBHL::Request.new()).to be_true
        else
          expect{RubyBHL::Request.new()}.to raise_error, API_KEY_MESSAGE
        end
      end

      it "uses ~/.bhl_api_key instead of ENV['BHL_API_KEY'] when provided" do
        if RubyBHL::API_KEY_FILE.nil? || RubyBHL::API_KEY_ENV.nil?
          pending API_KEY_MESSAGE
        else
          expect(RubyBHL::Request.new().api_key).to eq(RubyBHL::API_KEY_FILE )
        end
      end

      it "uses opts(:api_key) instead of ENV or ~/.bhl_api_key when provided" do
        if RubyBHL::API_KEY_FILE.nil? || RubyBHL::API_KEY_ENV.nil?
          pending API_KEY_MESSAGE
        else
          expect(RubyBHL::Request.new(api_key: 'foo').api_key).to eq('foo')
        end
      end

      it 'requires and :api_key to be set' do
        expect{RubyBHL::Request.new(api_key: nil)}.to raise_error
      end
    end
  end

end

