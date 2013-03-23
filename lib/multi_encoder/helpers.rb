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




#def qrcode(string, options = {})

##dont generate a barcode image again, if already generated
#unless File.exists?(out)
##generate the barcode object with all supplied options
#qrcode = QREncoder.encode(string)

##create the png image
#png = qrcode.png(options)
#png.save(out)
#end

