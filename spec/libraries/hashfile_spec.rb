require 'spec_helper'
require 'hashfile'

describe VagrantRepo::Hashfile do
  subject      { described_class.new(path) }
  let(:path)   { File.expand_path('../../fixtures/hashfile.txt', __FILE__) }

  its(:path)   { should eq path }
  its(:size)   { should eq 12 }
  its(:md5)    { should eq 'f0ef7081e1539ac00ef5b761b4fb01b3' }
  its(:sha1)   { should eq '33ab5639bfd8e7b95eb1d8d0b87781d4ffea4d5d' }
  its(:sha256) { should eq '1894a19c85ba153acbf743ac4e43fc004c891604b26f8c69e1e83ea2afc7c48f' }

  it 'returns relative path' do
    base = File.expand_path('../..', __FILE__)
    expect(subject.relative_path(base)).to eq 'fixtures/hashfile.txt'
  end
end
