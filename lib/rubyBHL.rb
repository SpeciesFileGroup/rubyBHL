# encoding: UTF-8

recent_ruby = RUBY_VERSION >= '2.0.0'
raise "IMPORTANT:  gem requires ruby >= 2.0.0" unless recent_ruby

require "json"
require 'net/http'

require_relative 'rubyBHL/request'
require_relative 'rubyBHL/response'

class RubyBHL

  #DEFAULT_TMP_DIR = "/tmp"
  
  def self.quick_request(options = {})
    opts = {
      params: {'name' => 'blorf'},
      method: :NameSearch
    }.merge!(options)
    request = RubyBHL::Request.new(opts)
    request.response
  end

end


