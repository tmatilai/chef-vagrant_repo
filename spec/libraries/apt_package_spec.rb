require 'spec_helper'
require 'apt_package'

describe VagrantRepo::AptPackage do
  let(:package) { described_class.new(tag, opts) }
  let(:opts) { Hash.new }

  describe '#version' do
    subject { package.version }

    context "with 'v' prefix" do
      let(:tag) { 'v1.2.3' }
      it { should eq '1.2.3' }
    end
    context "without 'v' prefix" do
      let(:tag) { 'deadbeef' }
      it { should eq tag }
    end
  end

  describe '#path' do
    subject { package.path }
    let(:tag) { 'v1.2.7' }
    let(:opts) { { 'ref' => 'gitsha1', 'arch' => arch } }

    context 'with amd64 package' do
      let(:arch) { 'amd64' }
      it { should eq 'gitsha1/vagrant_1.2.7_x86_64.deb' }
    end
    context 'with i386 package' do
      let(:arch) { 'i386' }
      it { should eq 'gitsha1/vagrant_1.2.7_i686.deb' }
    end
    context 'with other arch package' do
      let(:arch) { 'foo' }
      it { should eq 'gitsha1/vagrant_1.2.7_foo.deb' }
    end
  end
end
