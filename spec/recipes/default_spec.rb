require 'spec_helper'

describe 'vagrant_repo::default' do
  subject do
    ChefSpec::Runner.new.converge('vagrant_repo::default')
  end

  it { should include_recipe('vagrant_repo::apt') }
end
