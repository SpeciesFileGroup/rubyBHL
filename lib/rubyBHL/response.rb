class RubyBHL
  class Response
    attr_reader :json

    def initialize(options = {}) 
      opts = {
        request: nil 
      }.merge!(options)

      raise RubyBHL::Error if opts[:request].nil? || opts[:request].class != RubyBHL::Request

      @json = {}
      @json = JSON.parse(
        Net::HTTP.get_response(URI.parse(opts[:request].search_url)).body
        )
    end

  end
end
