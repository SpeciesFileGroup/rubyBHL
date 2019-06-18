require_relative '../spec_helper'

describe RubyBHL do
  subject { RubyBHL }

  it 'breaks for ruby 1.9.3 and older' do
    %w{1.8.7 1.9.2 1.9.3}.each do |v|
      stub_const('RUBY_VERSION', v) 
      expect{load File.expand_path('../../../lib/rubyBHL.rb', __FILE__)}.
        to raise_error RubyBHL::Error
    end
  end

  it 'has version' do
    expect(RubyBHL::VERSION =~ /\d+\.\d+\.\d/).to be_truthy
  end

  it 'has API_KEY_FILE_PATH' do
    expect(RubyBHL::API_KEY_FILE_PATH).to eq( File.expand_path("~/.bhl_api_key") )
  end

  describe '`quick_request`' do
    it 'exists as a class method' do
      expect(RubyBHL.public_methods.include?(:quick_request)).to be_truthy
    end

    it 'responds with a RubyBHL::Response' do
      expect(RubyBHL.quick_request().class).to eq(RubyBHL::Response) 
    end

    it 'makes a Net::HTTP request, and turns it into json' do
      expect(RubyBHL.quick_request().json).to eq({"Status"=>"ok", "ErrorMessage"=>"", "Result"=>[]}) 
    end

  end




end

