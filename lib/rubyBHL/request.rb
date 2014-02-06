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
      NameCountBetweenDates: %w{},                   # !! No documentation provided
     # NameGetDetailForName: %w{},                   # !! No documentation provided, can't confirm it works
     # NameGetDetailForNameBankID: %w{},             # !! No documentation provided, can't confirm it works
      NameList: %w{startrow batchsize stardate enddate},   # part of V1 !! may be problems
      NameListBetweenDates: %w{}, # !! No documentation provided 
      NameSearch: %w{name},                                # part of V1 !! may be problems
      PartSearch: %w{title containerTitle author date volume series issue}, 
      SubjectSearch: %w{subject}, 
      TitleSearchSimple: %w{title}, 
    }

    REQUIRED_PARAMS = {
      'name' => [:AuthorSearch, :NameSearch],
      'creatorid' => [:GetAuthorParts, :GetAuthorTitles],
      'type' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'value' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'itemid' => [:GetItemMetadata, :GetItemPages, :GetItemParts],
      'pageid' => [:GetPageMetadata, :GetPageNames, :GetPageOcrText, :GetPartBibTeX],
      'partid'  => [:GetPartBibTeX, :GetPartEndNote, :GetPartMetadata, :GetPartNames],
      'subject' => [:GetSubjectParts, :GetSubjectTitles, :SubjectSearch],
      'titleid' => [:GetTitleBibTex, :GetTitleEndNote, :GetTitleItems, :GetTitleMetadata],
      'title' => [:TitleSearchSimple] 
    }

    mrp = {}
    REQUIRED_PARAMS.each do |k,v|
      v.each do |m|
        mrp[m].push(k) if mrp[m] 
        mrp[m] ||= [k]
      end
    end

    METHODS_REQUIRED_PARAMS = mrp

    attr_accessor :params, :method, :format, :api_key
    attr_reader :search_url

    def initialize(options = {})
      opts = {
        api_key: RubyBHL::API_KEY,
        format:  RubyBHL::Request::FORMAT,
        method:  :NameSearch,
        params: { }
      }.merge!(options)

      assign_options(opts)
      build_url if valid?
    end

    def assign_options(opts)
      @api_key = opts[:api_key]
      @method = opts[:method]
      @format = opts[:format]
      @params = opts[:params]
    end

    def search_url
      build_url
      @search_url
    end

    def response
      build_url
      if valid?
        Response.new(request: self)
      else
        false # raise?
      end
    end

    def params_are_supported? 
      return false if @method.nil?
      return true if METHODS[@method] == []
      @params.keys - METHODS[@method] == []
    end

    def has_required_params?
      return false if @method.nil?
      return true if METHODS_REQUIRED_PARAMS[@method].nil?
      METHODS_REQUIRED_PARAMS[@method].select{|v| !@params.keys.include?(v)} == []
    end

    def valid?
      raise API_KEY_MESSAGE if @api_key.nil?
      raise "Method #{@method} not recognized." if @method && !RubyBHL::Request::METHODS.keys.include?(@method)
      raise "Format #{@format} not recognized." if @format && !%w{json xml}.include?(@format)

      !@method.nil? && !@format.nil? && params_are_supported? && has_required_params?
    end

    private 

    def build_url
      @search_url = SEARCH_BASE + 'op=' + @method.to_s +
        @params.keys.sort{|a,b| a.to_s <=> b.to_s}.collect{|k| "&#{k}=#{@params[k].to_s.gsub(/\s/, "+")}"}.join +
      '&format=' + @format + '&apikey=' + @api_key
    end

  end
end
