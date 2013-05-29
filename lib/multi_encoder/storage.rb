require 'active_support/core_ext/module/attribute_accessors'

module MultiEncoder
  module Storage
    mattr_reader :destination
    mattr_accessor :aws_bucket_prefix
    mattr_accessor :aws_access_key
    mattr_accessor :aws_secret_access_key

    def self.configure
      yield self
    end

    def self.destination=(dest)
      unless [:filesystem, :aws].include? dest
        raise ArgumentError.new('Unsopported storage distination mate')
      end
      @@destination = dest
    end
    self.destination = :filesystem
  end
end

require 'storage/aws'
require 'storage/filesystem'
