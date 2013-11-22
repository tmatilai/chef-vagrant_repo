require 'spec_helper'

describe 'vagrant_repo::apt' do

  context 'with default attributes' do
    subject { ChefSpec::Runner.new.converge('vagrant_repo::apt') }

    it { should include_recipe('nginx') }

    it { should create_directory('/usr/local/vagrant-apt/dists/stable/main/binary-amd64') }
    it { should create_directory('/usr/local/vagrant-apt/dists/stable/main/binary-i386') }

    it { should render_file('/usr/local/vagrant-apt/dists/stable/Release') }
    it { should render_file('/usr/local/vagrant-apt/dists/stable/main/binary-amd64/Packages') }
    it { should render_file('/usr/local/vagrant-apt/dists/stable/main/binary-i386/Packages') }
  end

end
