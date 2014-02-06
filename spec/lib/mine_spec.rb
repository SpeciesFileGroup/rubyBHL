require_relative '../spec_helper'
describe RubyBHL::Mine do
  subject { RubyBHL::Mine }
 
  describe "`taxon_attribute_table`" do

    it 'can be called with multiple attributes ' do
      expect(RubyBHL::Mine.taxon_attribute_table('Apis melifera', ['honey', 'yellow', 'plant'], 3)).to be_true
    end

    it 'can be limited to a number of pages' do
      t =  RubyBHL::Mine.taxon_attribute_table('Apis melifera', ['honey'], 5)
      expect(CSV.parse(t, col_sep: "\t").count).to eq(6) 
    end

    it 'returns a CSV formatted text string (tab delimited)' do
      t =  RubyBHL::Mine.taxon_attribute_table('Apis melifera', ['honey'], 1)
      expect(t.class).to eq(String)
      expect(CSV.parse(t, col_sep: "\t", headers: true)).to be_true
    end
  end


end
