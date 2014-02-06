
class RubyBHL

  class Response
    attr_reader :json

    def initialize(options = {}) 
      opts = {
        request: nil 
      }.merge!(options)

      raise if opts[:request].nil? || opts[:request].class != RubyBHL::Request

      @json = {}
      @json = JSON.parse(Net::HTTP.get_response(URI.parse(opts[:request].search_url)).body)
    end

  end
end


# Crud from 0.1.0
#   # # from the ruby doc
  # def fetch(uri_string, limit = 10)
  #   return nil if !uri_string
  #   limit = 10 # Justin Case we get in some redirect loop
  #   raise RbhlError, 'HTTP redirect too deep' if limit == 0 # should tweak
  #   response = Net::HTTP.get_response(URI.parse(uri_string))
  #   case response
  #   when Net::HTTPSuccess then response.body
  #   when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  #   else
  #     response.error!
  #   end
  # end
  # 
  # # this works on a redirect
  # def OCR_text(citation_index)
  #   return nil if !citation_index
  #   fetch(OCR_url(citation_index))
  # end

  # # Since the API doesn't return a link to the OCR we screen scrape the URL
  # def OCR_url(citation_index)
  #   Net::HTTP.get_response(URI.parse(@citations[citation_index]["Url"])).body =~ /http:\/\/.*?\.txt/
  #   return $& # the matched results
  # end
