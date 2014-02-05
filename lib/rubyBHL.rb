# encoding: UTF-8

recent_ruby = RUBY_VERSION >= '2.0.0'
raise "IMPORTANT:  gem requires ruby >= 2.0.0" unless recent_ruby

require_relative 'rubyBHL/request'
require_relative 'rubyBHL/response'

class RubyBHL

  #DEFAULT_TMP_DIR = "/tmp"
  

  def self.quick_request(options)
    opts = {
    }.merge!(options)
    request = RubyBHL::Request.new(options)
    request.response
  end

end

# module RubyBHL

# require 'net/http'
# require 'json/add/rails'
# # require 'json'



# class RbhlError < StandardError
# end

# class Rbhl
#   attr_accessor :opt
#   
#   def initialize(options = {}) 
#     # initialize once use many?
#     @opt = {
#       :openurl_version => '0.1',
#     }.merge!(options)  
#  end

#  def openURLRequest(options = {})
#    opt = {:params => {}}.merge(@opt).merge(options)

#    Request.new(opt)
#  end

# end

# end
