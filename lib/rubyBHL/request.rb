class RubyBHL
  
  API_KEY_FILE_PATH = File.expand_path("~/.bhl_api_key")
  key = nil
  key = File.read(API_KEY_FILE_PATH).strip if File.exists?(API_KEY_FILE_PATH)
  API_KEY_FILE = key 
  API_KEY_ENV = ENV['BHL_API_KEY'] 

  API_KEY = API_KEY_FILE || API_KEY_ENV || nil

  warn "\n\n !! API key not set in ~/.bhl_api_key, .env, or ENV.  You must pass requests an :api_key. !! \n\n"  if API_KEY.nil? || API_KEY == 'sekret_key_here'

  # Target API http://www.biodiversitylibrary.org/api2/docs/docs.html
  class RubyBHL::Request

    attr_reader :api_key

    def initialize(options = {})
      opts = {
        api_key: RubyBHL::API_KEY,
      }.merge!(options)

      @api_key = opts[:api_key]
      raise API_KEY_MESSAGE if @api_key.nil?
    end

    # some notes   
    # http://www.biodiversitylibrary.org/openurl?url_ver=Z39.88-2004&ctx_ver=Z39.88-2004 
    # rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook
    # rft.btitle
    # rft.jtitle
    # rft.au
    # rft.aufirst
    # rft.aulast
    # rft.publisher
    # rft.pub
    # rft.place
    # rft.date
    # rft.issn
    # rft.isbn
    # rft.coden
    # rft.stitle
    # rft.volume
    # rft.issue
    # rft.spage
    # rft_id=info:oclcnum/XXXX
    # rft_id=info:lccn/XXXX
    # rft_id=http://www.biodiversitylibrary.org/bibliography/XXXX
    # rft_id=http://www.biodiversitylibrary.org/page/XXXX

    # require File.expand_path(File.join(File.dirname(__FILE__), '../lib/**/*.rb'))

    FORMAT = 'json'

    ROOT_URL = 'http://www.biodiversitylibrary.org'

    # see http://docs.google.com/Doc?id=dgvjvvkz_1x5qbm3 for the Name Services
    NAME_SEARCH_URL = "#{ROOT_URL}/services/name/NameService.ashx"
    SEARCH_URL =  "#{ROOT_URL}/openurl?" 

    STABLE_URLS = [:subject, :creator, :title, :item, :page]

    VALID_PARAMS = {'0.1' => [
      :title,
      :au,
      :aufirst,
      :aulast,
      :publisher,
      :date,
      :issn,
      :isbn,
      :coden,
      :stitle,
      :volume,
      :issue,
      :spage]}

    attr :search_url

    def init(options = {}) 
      @opt = {
      }.merge!(options)

      # check for legal parameters
      @opt[:params].keys.each do |p|
        raise RbhlError, "#{p} is not a valid parameter" if !VALID_PARAMS[@opt[:openurl_version]].include?(p)
      end 

      @search_url = SEARCH_URL + 
        @opt[:params].keys.sort{|a,b| a.to_s <=> b.to_s}.collect{|k| "#{k}=#{@opt[:params][k].gsub(/\s/, "+")}"}.join("&") +
      '&format=' + @opt[:format]       

    end

    # from the ruby doc
    def fetch(uri_string, limit = 10)
      return nil if !uri_string
      limit = 10 # Justin Case we get in some redirect loop
      raise RbhlError, 'HTTP redirect too deep' if limit == 0 # should tweak
      response = Net::HTTP.get_response(URI.parse(uri_string))
      case response
      when Net::HTTPSuccess then response.body
      when Net::HTTPRedirection then fetch(response['location'], limit - 1)
      else
        response.error!
      end
    end

    def get_response
      Response.new(self)
    end

  end
  end
