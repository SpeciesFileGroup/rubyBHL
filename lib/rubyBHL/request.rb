class RubyBHL

  API_KEY_FILE_PATH = File.expand_path("~/.bhl_api_key")
  key = nil
  key = File.read(API_KEY_FILE_PATH).strip if File.exists?(API_KEY_FILE_PATH)
  API_KEY_FILE = key 
  API_KEY_ENV = ENV['BHL_API_KEY'] 

  API_KEY = API_KEY_FILE || API_KEY_ENV || nil

  warn "\n\n !! API key not set in ~/.bhl_api_key, .env, or ENV.  You must pass requests an :api_key. !! \n\n"  if API_KEY.nil? || API_KEY == 'sekret_key_here'

  # Target API https://www.biodiversitylibrary.org/api3
  class RubyBHL::Request
    BASE_URL = 'https://www.biodiversitylibrary.org'
    API_VERSION = 'api3'
    FORMAT = 'json'
    SEARCH_BASE = [BASE_URL, API_VERSION].join("/") + '?'

    METHODS = { 
      AuthorSearch: %w{authorname},
      GetAuthorMetadata: %w{id idtype pubs},
      GetCollections: %w{},   # no params
      GetInstitutions: %w{},  # no params
      GetItemMetadata: %w{id idtype pages ocr parts},
      GetLanguages: %w{},     # no params
      GetNameMetadata: %w{name idtype id}, # either name or idtype + id is required
      GetPageMetadata: %w{pageid ocr names}, 
      GetPartMetadata: %w{id idtype names},
      GetSubjectMetadata: %w{subject pubs},
      GetTitleMetadata: %w{id idtype items},
      NameSearch: %w{name},     # part of V1 !! may be problems
      PageSearch: %w{itemid text},
      PublicationSearch: %w{searchterm searchtype page},
      PublicationSearchAdvanced: %w{title titleop authorname year subject language collection text textop page},
      SubjectSearch: %w{subject}, 
    }

    # See also comments above
    REQUIRED_PARAMS = {
      'authorname' => [:AuthorSearch],
      'name' => [:AuthorSearch, :NameSearch],
      'creatorid' => [:GetAuthorParts, :GetAuthorTitles],
      'type' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'value' => [:GetItemByIdentifier, :GetPartByIdentifier, :GetTitleByIdentifier],
      'itemid' => [:GetItemMetadata, :GetItemPages, :GetItemParts],
      'pageid' => [:GetPageMetadata, :GetPageNames, :GetPageOcrText, :GetPartBibTeX],
      'partid' => [:GetPartBibTeX, :GetPartEndNote, :GetPartMetadata, :GetPartNames],
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
      raise(RubyBHL::Error, API_KEY_MESSAGE) if @api_key.nil?
      raise(RubyBHL::Error, "Method #{@method} not recognized.") if @method && !RubyBHL::Request::METHODS.keys.include?(@method)

      raise(RubyBHL::Error, "Format #{@format} not recognized.") if @format && !%w{json xml}.include?(@format)

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
