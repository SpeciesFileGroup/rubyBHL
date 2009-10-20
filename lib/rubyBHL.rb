module RubyBHL
  
 # Some quick hacks, only configured for json right now.

 require 'net/http'
 # require 'json'
 require 'json/add/rails'

 class RbhlError < StandardError
 end

 class Rbhl
   
 # some notes   
 #http://www.biodiversitylibrary.org/openurl?url_ver=Z39.88-2004&ctx_ver=Z39.88-2004
 #rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook
 #rft.btitle
 #rft.jtitle
 #rft.au
 #rft.aufirst
 #rft.aulast
 #rft.publisher
 #rft.pub
 #rft.place
 #rft.date
 #rft.issn
 #rft.isbn
 # rft.coden
 # rft.stitle
 # rft.volume
 # rft.issue
 # rft.spage
 # rft_id=info:oclcnum/XXXX
 # rft_id=info:lccn/XXXX
 # rft_id=http://www.biodiversitylibrary.org/bibliography/XXXX
 # rft_id=http://www.biodiversitylibrary.org/page/XXXX
  
  # "constants" (defaults really)
  SEARCH_URL =  'http://www.biodiversitylibrary.org/openurl?' 
  FORMAT = 'json'
  #  METHOD = '' # openURL0.1, openURL1.0 

  PARAMETERS = [
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
                  :spage]
  
  # created from response
  attr_reader(:json_data)
  attr_reader(:citations)
  attr :search_url

 def initialize(options = {}) 
   @opt = {
    #  :method => METHOD,
      :format => FORMAT,
      :params => {}
   }.merge!(options)
   
   # check for legal parameters
   @opt[:params].keys.each do |p|
      raise RbhlError, "#{p} is not a valid parameter" if !PARAMETERS.include?(p)
   end 
     
   @json_data = {}
     
   @search_url = SEARCH_URL + 
       @opt[:params].keys.sort{|a,b| a.to_s <=> b.to_s}.collect{|k| "#{k}=#{@opt[:params][k].gsub(/\s/, "+")}"}.join("&") +
      '&format=' + @opt[:format]       
       
   @json_data = JSON.parse(Net::HTTP.get_response(URI.parse(@search_url)).body)
   @citations = @json_data['citations'] if @json_data['Status'] == 1 # a simpler reference
   
   true
 end

 # this works on a redirect
 def OCR_text(citation_index)
   return nil if !citation_index
   fetch(OCR_url(citation_index))
 end

 # Since the API doesn't return a link to the OCR we screen scrape it the URL
 def OCR_url(citation_index)
   Net::HTTP.get_response(URI.parse(@citations[citation_index]["Url"])).body =~ /http:\/\/.*?\.txt/
   return $& # the matched results
 end

 protected
 
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
 

end


end
