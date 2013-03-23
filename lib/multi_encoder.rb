$: << File.dirname(__FILE__) + '/multi_encoder'

module MultiEncoder
end

require 'version'
require 'qrencoder'
require 'gbarcode'
require 'storage'
require 'images'
require 'railtie' if defined? Rails
