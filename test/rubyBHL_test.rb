require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/rubyBHL'))

include RubyBHL

class RubyBHLTest < Test::Unit::TestCase

  def setup
  end

  def test_vanilla_init
    assert @bhl = Rbhl.new()
  end

  def test_vanilla_request
    @bhl = Rbhl.new
    assert @bhl.openURLRequest()
  end

  def test_foo_is_not_a_legal_param
    assert_raise(RubyBHL::RbhlError) {RubyBHL::Rbhl.new(:params => {:foo => "BAR!"}) }   
  end

  def test_search_url_for_default_url_is_properly_formed
    @bhl = RubyBHL::Rbhl.new(:params => {:title => "BAR!", :volume => "2"})
    assert_equal "http://www.biodiversitylibrary.org/openurl?title=BAR!&volume=2&format=json", @bhl.search_url 
  end

  def test_search_url_convert_space_to_plus
    @bhl = RubyBHL::Rbhl.new(:params => {:title => "BAR FOO"})
    assert_equal "http://www.biodiversitylibrary.org/openurl?title=BAR+FOO&format=json", @bhl.search_url 
  end

  def test_basic_response_is_returned
    # this is a crummy test, we need a reference to the status codes.
    @bhl = RubyBHL::Rbhl.new(:params => {:title => "BAR FOO"}) # should match nothing, I hope
    assert @bhl.json_data["Status"] == 1
    assert @bhl.json_data["citations"].size == 0
  end

  def test_response_with_citations_is_returned
    # this is a crummy test, we need a reference to the status codes.
    @bhl = RubyBHL::Rbhl.new(:params => {:title => "Manual of North American Diptera"}) 
    assert @bhl.json_data["citations"].size > 0
  end

  def test_OCR_text_scraping
    @bhl = RubyBHL::Rbhl.new(:params => {:title => "Manual of North American Diptera"}) 
    assert @bhl.OCR_text(0).size > 0
    assert @bhl.OCR_text(0) =~ /Diptera/ 
  end


end
