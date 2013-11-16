require 'spec_helper'

describe 'vagrant_repo::apt' do
  subject do
    ChefSpec::Runner.new.converge('vagrant_repo::apt')
  end

  it { should include_recipe('nginx') }
end
