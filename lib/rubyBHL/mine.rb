class RubyBHL

  require 'csv'

  # Some rudimentary methods for mining the BHL.
  class Mine 

    # Takes a string, and a list of "attributes" (keyword). 
    # Returns a CSV object with one line per page, 
    # one column per attribute, 
    # 1 if keyword was found, 0 if not.
    def self.taxon_attribute_table(taxon_name = nil, attributes = [], page_limit = 10)
      name_search = RubyBHL::Request.new(method: :NameGetDetail , params: {'name' => taxon_name}) 

      json = name_search.response.json
      pages = pages_from_result(json['Result'])

      csv = CSV.generate(col_sep: "\t") do |csv|
        csv << [*attributes, 'PageID']
        pages[0..page_limit - 1].each do |p|
          result = []
          ocr = RubyBHL::Request.new(method: :GetPageOcrText, params: {'pageid' => p['PageID']}).response.json['Result']
          result += bit_vector_for_keywords(ocr, attributes)
          result.push p['PageID']
          csv << [*result]
        end
      end
      csv
    end

    # return an Array of 0 or 1 given the presence or absence of each keyword in the text
    def self.bit_vector_for_keywords(text = "", keywords = [])
      keywords.inject([]) {|ary, k| ary.push(text =~ /#{k}/ ? 1 : 0) }
    end 

    # TODO: Use JSON fu to make this simpler
    def self.pages_from_result(results = [])
      pages = []
      results['Titles'].each do |t|
        t['Items'].each do |i|
          pages += i['Pages']
        end
      end
      pages
    end

  end
end
