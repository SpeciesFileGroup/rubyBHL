require_relative '../spec_helper'

describe RubyBHL do
  subject { RubyBHL }

  it 'breaks for ruby 1.9.3 and older' do
    %w{1.8.7 1.9.2 1.9.3}.each do |v|
      stub_const('RUBY_VERSION', v) 
      expect{load File.expand_path('../../../lib/rubyBHL.rb', __FILE__)}.
        to raise_error
    end
  end

  it 'has version' do
    expect(RubyBHL::VERSION =~ /\d+\.\d+\.\d/).to be_true
  end

  it 'has API_KEY_FILE_PATH' do
    expect(RubyBHL::API_KEY_FILE_PATH).to eq( File.expand_path("~/.bhl_api_key") )
  end

  it 'has a `quick_request`' do
    expect(RubyBHL.public_methods.include?(:quick_request)).to be_true
  end


end

