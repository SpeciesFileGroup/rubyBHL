# require 'coveralls'
# Coveralls.wear!

require 'dotenv'
Dotenv.load

require 'rubyBHL' 
require 'awesome_print'
require 'byebug'

API_KEY_MESSAGE =  "Add a key to ~/.bhl_api_key and/or ensure ENV['BHL_API_KEY'] is set for this test to pass or be tested."

RSpec.configure do |config|

end
