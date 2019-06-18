require_relative '../spec_helper'
describe RubyBHL::Response do
  subject { RubyBHL::Response }

  it 'requires a response' do
    expect{ RubyBHL::Response.new() }.to raise_error RubyBHL::Error
  end

  it 'a valid request does not raise' do
    request = RubyBHL::Request.new(params: {'name' => 'blorf'})
    expect(request.valid?).to be_truthy
    expect{ RubyBHL::Response.new(request: request) }.not_to raise_error
  end
end

# def test_OCR_text_scraping
#   @bhl = RubyBHL::Rbhl.new(:params => {:title => "Manual of North American Diptera"})
#   assert @bhl.OCR_text(0).size > 0
#   assert @bhl.OCR_text(0) =~ /Diptera/
# end

