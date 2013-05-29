module MultiEncoder
  module Storage
    module FileSystem

      def url
        if defined? Rails
          file_path.to_s.gsub Rails.root.join('public').to_s, ''
        end
      end

      def root
        defined?(Rails) ? Rails.root : Pathname.new('/tmp')
      end

      def directory
        root.join 'public', 'system', type, *fingerprint
      end

      def file_path
        Pathname.new "#{directory.join(@contents)}.#{MultiEncoder::BarcodeImage::OUTPUT_FORMAT}"
      end

      def exists?
        file_path.exist?
      end

      private
      def eps_path
        "/tmp/#{@contents}.eps"
      end
    end
  end
end
