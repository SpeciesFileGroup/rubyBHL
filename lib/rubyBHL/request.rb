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
    BASE_URL = 'http://www.biodiversitylibrary.org'
    API_VERSION = 'api2'  
    INTERFACE = 'httpquery.ashx?'
    FORMAT = 'json'
    SEARCH_BASE = [BASE_URL, API_VERSION, INTERFACE].join("/") 
    
    METHODS = { 
      AuthorSearch: %w{name},
      BookSearch: %w{title lname volume edition year subject language collectionid}, 
      GetAuthorParts: %w{creatorid}, 
      GetAuthorTitles: %w{creatorid},  
      GetCollections: %w{},        # no params
      GetItemByIdentifier: %w{type value}, 
      GetItemMetadata: %w{itemid pages oc parts}, 
      GetItemPages: %w{itemid ocr}, 
      GetItemParts: %w{itemid}, 
      GetLanguages: %w{},          # no params
      GetPageMetadata: %w{pageid ocr names}, 
      GetPageNames: %w{pageid}, 
      GetPageOcrText: %w{pageid}, 
      GetPartBibTeX: %w{partid}, 
      GetPartByIdentifier: %w{type value}, 
      GetPartEndNote: %w{partid}, 
      GetPartMetadata: %w{partid}, 
      GetPartNames: %w{partid}, 
      GetSubjectParts: %w{subject}, 
      GetSubjectTitles: %w{subject}, 
      GetTitleBibTex: %w{titleid}, 
      GetTitleByIdentifier: %w{type value}, 
      GetTitleEndNote: %w{titleid}, 
      GetTitleItems: %w{titleid}, 
      GetTitleMetadata: %w{titleid items}, 
      GetUnpublishedItems: %w{},      # No params 
      GetUnpublishedParts: %w{},      # No params 
      GetUnpublishedTitles: %w{},     # No params 
      NameCount: %w{startdate enddate}, 
      NameGetDetail: %w{namebankid name},            # !! Not in list below part of V1, see || criteria
      NameCountBetweenDates: %w{},          # !! No documentation provided
      NameGetDetailForName: %w{},           # !! No documentation provided
      NameGetDetailForNameBankID: %w{},     # !! No documentation provided
      NameList: %w{startrow batchsize stardate enddate},   # part of V1 !! may be problems
      NameListBetweenDates: %w{}, # !! No documentation provided 
      NameSearch: %w{name},                                # part of V1 !! may be problems
      PartSearch: %w{title containerTitle author date volume series issue}, 
      SubjectSearch: %w{subject}, 
      TitleSearchSimple: %w{title}, 
    }


    attr_reader :params, :method, :format, :api_key, :search_url

    def initialize(options = {})
      opts = {
        api_key: RubyBHL::API_KEY,
        format:  RubyBHL::Request::FORMAT,
        method:  :NameSearch,
        params: { }
      }.merge!(options)

      assign_and_validate_options(opts)
      build_url
    end

    def assign_and_validate_options(opts)
      @api_key = opts[:api_key]
      raise API_KEY_MESSAGE if @api_key.nil?

      @method = opts[:method]
      raise "Method #{@method} not recognized." if @method && !RubyBHL::Request::METHODS.keys.include?(@method)

      @format = opts[:format]
      raise "Format #{@format} not recognized." if @format && !%w{json xml}.include?(@format)

      # TODO: check params against method
      @params = opts[:params]
    end

    def build_url
      @search_url = SEARCH_BASE + 
        @params.keys.sort{|a,b| a.to_s <=> b.to_s}.collect{|k| "#{k}=#{opts[:params][k].gsub(/\s/, "+")}"}.join("&") +
      '&format=' + @format
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

 #  def get_response
 #    Response.new(self)
 #  end

  end
end
