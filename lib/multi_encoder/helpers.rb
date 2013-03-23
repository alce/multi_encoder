module MultiEncoder
  module Helpers
    def barcode(string, options = {})
      image = BarcodeImage.new string, options
      image_tag image.href
    end

    def qrcode(string, options = {})
      image = QRcodeImage.new string, options
      image_tag image.href
    end
  end
end
