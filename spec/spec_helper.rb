require 'chefspec'
require 'chefspec/berkshelf'
require 'pathname'

spec_root     = Pathname(__FILE__).parent
cookbook_root = spec_root.parent

# Add cookbook's libraries/ to the load path
$LOAD_PATH.unshift(cookbook_root.join('libraries'))

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.color = true
  config.tty = true

  # ChefSpec configuration
  config.log_level = :error
  config.platform = 'debian'
  config.version = '7.1'
end
