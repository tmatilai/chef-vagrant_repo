require 'spec_helper'
require 'apt_packages'

describe VagrantRepo::AptPackages do
  subject { instance }
  let(:instance) { described_class.new(node) }
  let(:node) do
    {
      'vagrant_repo' => {
        'apt' => {
          'root_dir' => '/opt',
          'suite' => 'foo',
          'component' => 'bar',
          'architectures' => %w[arch1 arch2],
          'packages' => package_data
        }
      }
    }
  end
  let(:package_data) do
    [{
      'tag' => 'v1.2.3',
      'ref' => 'abc456',
      'arch2' => {
        'size' => '9876',
        'md5'  => '12345'
      }
    }]
  end

  its(:architectures) { should eq %w[arch1 arch2] }

  describe '#directory' do
    subject { instance.directory('baz') }
    it { should eq '/opt/dists/foo/bar/binary-baz' }
  end

  describe '#packages' do
    subject { instance.packages }

    it { should be_an Array }
    its(:length) { should eq 1 }

    it 'creates AptPackages' do
      pkg = subject.first

      expect(pkg.tag).to eq 'v1.2.3'
      expect(pkg.ref).to eq 'abc456'
      expect(pkg.arch).to eq 'arch2'
      expect(pkg.size).to eq '9876'
      expect(pkg.md5).to eq '12345'
    end
  end

  context 'with empty data' do
    let(:package_data) { [] }

    its(:packages) { should eq [] }
    its(:group_by_arch) { should eq({}) }
  end
end
