# encoding: UTF-8

recent_ruby = RUBY_VERSION >= '2.5.0'
raise(RubyBHL::Error, "IMPORTANT:  gem requires ruby >= 2.0.0") unless recent_ruby

require "json"
require 'net/http'

require_relative 'rubyBHL/request'
require_relative 'rubyBHL/response'
require_relative 'rubyBHL/mine'

class RubyBHL

  def self.quick_request(options = {})
    opts = {
      params: {'name' => 'blorf'},
      method: :NameSearch
    }.merge!(options)
    request = RubyBHL::Request.new(opts)
    request.response
  end

end

class RubyBHL::Error < StandardError; end;
