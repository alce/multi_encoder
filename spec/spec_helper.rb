$: << File.dirname(__FILE__) + '../lib/'

require 'multi_encoder'
require 'pathname'

RSpec.configure do |config|
  config.before { MultiEncoder::Storage.destination = :filesystem }
end

