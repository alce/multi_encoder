module MultiEncoder
  module Storage
    module FileSystem

      def url
        file_path
      end

      def directory
        if defined? Rails
          Rails.root.join 'public', 'system', 'barcodes', *fingerprint
        else
          Pathname.new '/tmp'
        end
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
