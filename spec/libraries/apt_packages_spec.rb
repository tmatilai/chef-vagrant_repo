require 'spec_helper'
require 'apt_packages'

describe VagrantRepo::AptPackages do
  describe '.directory' do
    subject { described_class.directory(node, arch) }
    let(:node) do
      {
        'vagrant_repo' => {
          'apt' => {
            'root_dir' => '/opt',
            'suite' => 'foo',
            'component' => 'bar'
          }
        }
      }
    end
    let(:arch) { 'baz' }

    it { should eq '/opt/dists/foo/bar/binary-baz' }
  end

  let(:instance) { described_class.new(archs, data) }
  let(:archs) { %w[amd64 i386] }

  context 'with empty data' do
    subject { instance }
    let(:data) { [] }

    its(:packages) { should eq [] }
    its(:group_by_arch) { should eq({}) }
  end
end
