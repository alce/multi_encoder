# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_encoder/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_encoder"
  spec.version       = MultiEncoder::VERSION
  spec.authors       = ["Juan Alvarez"]
  spec.email         = ["alce@mac.com"]
  spec.description   = %q{QRCode and Barcode generator for rails}
  spec.summary       = %q{QRCode and Barcode generator for rails}
  spec.homepage      = "https://github.com/alce/multi_encoder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "ext"]
  spec.extensions = ["ext/gbarcode/extconf.rb"]

  spec.required_ruby_version = ">= 1.9.2"
  spec.requirements << "ImageMagick"

  spec.add_dependency "qrencoder", "= 1.4.1"
  spec.add_dependency "activesupport", ">= 3.0.0"
  spec.add_dependency "actionpack", ">= 3.0.0"
  spec.add_dependency "fog", "~> 1.16.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake-compiler"

end
