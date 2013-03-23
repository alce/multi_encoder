require 'active_support/concern'

module MultiEncoder
  module Storage
    module AWS
      extend ActiveSupport::Concern

      included { require 'fog' }

      def url
      end

      def exists?
      end

      def write
      end

      private
      def connection
        ::Fog::Storage.new({
          provider: 'AWS',
          aws_access_key_id: ENV['AWS_ACCESS_KEY'],
          aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        })
      end
    end
  end
end
