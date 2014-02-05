require_relative '../spec_helper'

describe RubyBHL do
  subject { RubyBHL }

  # let(:file_dir) { File.expand_path('../../files', __FILE__) }

  it 'breaks for ruby 2.0 and older' do
    %w{1.8.7 1.9.2 1.9.3}.each do |v|
      stub_const('RUBY_VERSION', v) 
      expect{load File.expand_path('../../../lib/RubyBHL.rb', __FILE__)}.
        to raise_error
    end
  end

  it 'continues for ruby 2.0.0 and higher' do
    stub_const('RUBY_VERSION', '2.0.0') 
    expect{load File.expand_path('../../../lib/RubyBHL.rb', __FILE__)}.
      to_not raise_error
  end

  it 'has version' do
    expect(RubyBHL::VERSION =~ /\d+\.\d+\.\d/).to be_true
  end

  it 'has a quick_request method' do
    expect(RubyBHL.public_methods.include?(:quick_request)).to be_true
  end




# describe '.clean_all' do
#   let(:tmp_dir) { DarwinCore::DEFAULT_TMP_DIR }

#   it 'cleans dwca directories' do
#     Dir.chdir(tmp_dir)
#     FileUtils.mkdir('dwc_123') unless File.exists?('dwc_123')
#     dwca_dirs =  Dir.entries(tmp_dir).select { |d| d.match(/^dwc_[\d]+$/) }
#     expect(dwca_dirs.size).to be > 0
#     subject.clean_all
#     dwca_dirs =  Dir.entries(tmp_dir).select { |d| d.match(/^dwc_[\d]+$/) }
#     expect(dwca_dirs.size).to be 0
#   end

#   context 'no dwc files exist' do
#     it 'does nothing' do
#       subject.clean_all
#       subject.clean_all
#       dwca_dirs =  Dir.entries(tmp_dir).select { |d| d.match(/^dwc_[\d]+$/) }
#       expect(dwca_dirs.size).to be 0
#     end
#   end
# end

# describe '.logger' do
#   it { expect(subject.logger).to be_kind_of Logger }
# end

# describe '.logger=' do
#   it 'sets logger' do
#     expect(subject.logger = 'fake logger').to eq 'fake logger'
#     expect(subject.logger).to eq 'fake logger'
#   end
# end

# describe '.logger_reset' do
#   it 'resets logger' do
#     subject.logger = 'fake logger'
#     expect(subject.logger).to eq 'fake logger'
#     subject.logger_reset
#     expect(subject.logger).to be_kind_of Logger
#   end
# end

# describe '.new' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#  
#   context 'tar.gz and zip files supplied' do 
#     files = %w(data.zip data.tar.gz minimal.tar.gz junk_dir_inside.zip)
#     files.each do |file|
#       let(:file_path) { File.join(file_dir, file) }

#       it "creates archive from  %s" % file do
#         expect(dwca.archive.valid?).to be_true
#       end

#     end
#   end

#   context 'when file does not exist' do
#     let(:file_path) { File.join(file_dir, 'no_file.gz') }

#     it 'raises not found' do
#        expect { dwca }.to raise_error DarwinCore::FileNotFoundError
#     end
#   end

#   context 'archive cannot unpack' do

#     let(:file_path) { File.join(file_dir, 'broken.tar.gz') }

#     it 'raises unpacking error' do
#       expect { dwca }.to raise_error DarwinCore::UnpackingError
#     end
#   end

#   context 'archive is broken' do

#     let(:file_path) { File.join(file_dir, 'invalid.tar.gz') }

#     it 'raises error of invalid archive' do
#       expect { dwca }.to raise_error DarwinCore::InvalidArchiveError
#     end

#   end
#   
#   context 'archive is not in utf-8 encoding' do

#     let(:file_path) { File.join(file_dir, 'latin1.tar.gz') }
#     
#     it 'raises wrong encoding error' do
#       expect { dwca }.to raise_error DarwinCore::EncodingError
#     end

#   end
#   
#   context 'filename with spaces and non-alphanumeric chars' do

#     let(:file_path) { File.join(file_dir, 'file with characters(3).gz') }
#     
#     it 'creates archive' do
#       expect(dwca.archive.valid?).to be_true
#     end

#   end
# end

# describe 'file_name' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns file name' do
#     expect(dwca.file_name).to eq 'data.tar.gz'
#   end
# end

# describe 'path' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns path of the archive' do
#     expect(dwca.path).to match %r|spec.files.data\.tar\.gz|
#   end
# end

# describe '#archive' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns archive' do
#     expect(dwca.archive).to be_kind_of DarwinCore::Archive
#   end
# end

# describe '#core' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns core' do
#     expect(dwca.core).to be_kind_of DarwinCore::Core
#   end
# end

# describe '#metadata' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns eml' do
#     expect(dwca.eml).to be_kind_of DarwinCore::Metadata
#     expect(dwca.metadata).to be_kind_of DarwinCore::Metadata
#   end
# end
# 
# describe '#extensions' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'returns extensions' do
#     extensions = dwca.extensions
#     expect(extensions).to be_kind_of Array
#     expect(extensions[0]).to be_kind_of DarwinCore::Extension 
#   end
# end

# describe '#checksum' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }

#   it 'creates checksum hash' do
#     expect(dwca.checksum).to eq '7d94fc28ffaf434b66fbc790aa5ef00d834057bf'
#   end
# end

# describe '#has_parent_id' do
#   subject(:dwca) { DarwinCore.new(file_path) }

#   context 'has classification' do
#     let(:file_path) { File.join(file_dir, 'data.tar.gz') }
#     it 'returns true' do
#       expect(dwca.has_parent_id?).to be_true
#     end
#   end

#   context 'does not have classification' do
#     let(:file_path) { File.join(file_dir, 'gnub.tar.gz') }
#     it 'returns false' do
#       expect(dwca.has_parent_id?).to be_false
#     end
#   end
# end

# describe '#classification_normalizer' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }
#  
#   context 'not initialized' do
#     it 'is nil' do
#       expect(dwca.classification_normalizer).to be_nil
#     end
#   end

#   context 'initialized' do
#     it 'is DarwinCore::ClassificationNormalizer' do
#       dwca.normalize_classification
#       expect(dwca.classification_normalizer).
#         to be_kind_of DarwinCore::ClassificationNormalizer 
#     end
#   end
# end

# describe '#normalize_classification' do
#   subject(:dwca) { DarwinCore.new(file_path) }
#   let(:file_path) { File.join(file_dir, 'data.tar.gz') }
#   let(:normalized) { dwca.normalize_classification }

#   it 'returns hash' do
#     expect(normalized).to be_kind_of Hash
#   end

#   it 'uses utf-8 encoding for classification paths' do
#     encodings = []
#     normalized.each do |taxon_id, taxon|
#       taxon.classification_path.each { |p| encodings << p.encoding }
#     end
#     expect(encodings.uniq!.map { |e| e.to_s }).to eq ['UTF-8']
#   end

#   it 'has elements of DarwinCore::TaxonNormalized type' do
#     expect(normalized['leptogastrinae:tid:2857']).
#       to be_kind_of DarwinCore::TaxonNormalized
#   end
# end

end

