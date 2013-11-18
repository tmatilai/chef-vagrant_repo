require 'spec_helper'
require 'apt_packages'

describe VagrantRepo::AptPackages do
  let(:instance) { described_class.new(archs, data) }
  let(:archs) { %w[amd64 i386] }

  context 'with empty data' do
    subject { instance }
    let(:data) { [] }

    its(:packages) { should eq [] }
    its(:group_by_arch) { should eq({}) }
  end
end
