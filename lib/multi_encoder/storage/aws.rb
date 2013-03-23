require 'active_support/concern'

module MultiEncoder
  module Storage
    module AWS
      extend ActiveSupport::Concern

      included { require 'fog' }

      def url
        file.public_url
      end

      def file
        @file ||= aws_directory.files.get(filename)
      end

      def root
        Pathname.new('/tmp')
      end

      def directory
        root.join 'public', 'system', type, *fingerprint
      end

      def aws_directory
        env = defined?(Rails) ? Rails.env : 'gem-dev'
        @aws_directory ||= connection.directories.create({
          key: "boletia-#{env}-#{type}",
          public: true
        })
      end

      def file_path
        Pathname.new "/tmp/#{filename}.png"
      end

      def exists?
        !!aws_directory.files.head(filename)
      end

      def save
        aws_directory.files.create({
          body: IO.read(file_path),
          key: filename,
          public: true,
          content_type: 'image/png'
        })
      end

      def delete
        file.destroy
      end

      private
      def filename
        fingerprint.join
      end

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
