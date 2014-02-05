require_relative '../spec_helper'
describe RubyBHL::Request do

  subject { RubyBHL::Request }

  describe 'API key' do


  end

  describe 'instances' do
    before(:each) {
      @r = RubyBHL::Request.new()
    }

    it "has a `api_key` attribute" do
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

  end

end

