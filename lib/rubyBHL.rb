module RubyBHL

require 'net/http'
require 'json/add/rails'
# require 'json'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/Request'))

class RbhlError < StandardError
end

class Rbhl
  attr_accessor :opt
  
  def initialize(options = {}) 
    # initialize once use many?
    @opt = {
      :openurl_version => '0.1',
    }.merge!(options)  
 end

 def openURLRequest(options = {})
   opt = {:params => {}}.merge(@opt).merge(options)

   Request.new(opt)
 end

end

end
