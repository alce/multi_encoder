require 'tempfile'

module MultiEncoder
  class BarcodeImage < AbstractImage

    DEFAULT_ENCODING = Gbarcode::BARCODE_39 | Gbarcode::BARCODE_NO_CHECKSUM

    def type
      'barcodes'
    end

    def write
      barcode = Gbarcode.barcode_create @contents.upcase
      Gbarcode.barcode_encode extract_options(barcode), DEFAULT_ENCODING
      FileUtils.mkdir_p directory
      eps = File.open("#{eps_path}", 'wb')

      begin
        Gbarcode.barcode_print barcode, eps, Gbarcode::BARCODE_OUT_EPS
        system("convert #{eps_path} #{file_path}")
      ensure
        eps.close
        FileUtils.rm eps
      end
      save if respond_to? :save
    end

    private
    def extract_options(bc)
      bc.width  = @options[:width] if @options[:width]
      bc.height = @options[:height] if @options[:height]
      bc.scalef = @options[:scaling_factor] if @options[:scaling_factor]
      bc.xoff   = @options[:xoff] if @options[:xoff]
      bc.yoff   = @options[:yoff]  if @options[:yoff]
      bc.margin = @options[:margin]  if @options[:margin]
      bc
    end
  end
end
