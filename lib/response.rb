class Response
  attr_reader(:json_data)
  attr_reader(:citations)

  def init(options = {}) 
    @opt = {
    }.merge!(options)
       @json_data = {}
       @json_data = JSON.parse(Net::HTTP.get_response(URI.parse(@search_url)).body)
       @citations = @json_data['citations'] if @json_data['Status'] == 1 # a simpler reference
  end


 # this works on a redirect
 def OCR_text(citation_index)
   return nil if !citation_index
   fetch(OCR_url(citation_index))
 end

 # Since the API doesn't return a link to the OCR we screen scrape the URL
 def OCR_url(citation_index)
   Net::HTTP.get_response(URI.parse(@citations[citation_index]["Url"])).body =~ /http:\/\/.*?\.txt/
   return $& # the matched results
 end

end

