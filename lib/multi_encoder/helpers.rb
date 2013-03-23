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



#output_format = 'png'
#id.upcase!

#path = Rails.root.join('public', 'system', 'barcodes', *Digest::MD5.hexdigest(id).first(9).scan(/.../))
#FileUtils.mkdir_p(path)
#eps = "#{path}/#{id}.eps"
#out = "#{path}/#{id}.#{output_format}"

##dont generate a barcode again, if already generated
#unless File.exists?(out)
##generate the barcode object with all supplied options
#options[:encoding_format] = DEFAULT_ENCODING unless options[:encoding_format]
#bc = Gbarcode.barcode_create(id)
#bc.width  = options[:width]          if options[:width]
#bc.height = options[:height]         if options[:height]
#bc.scalef = options[:scaling_factor] if options[:scaling_factor]
#bc.xoff   = options[:xoff]           if options[:xoff]
#bc.yoff   = options[:yoff]           if options[:yoff]
#bc.margin = options[:margin]         if options[:margin]
#Gbarcode.barcode_encode(bc, options[:encoding_format])

#if options[:no_ascii]
#print_options = Gbarcode::BARCODE_OUT_EPS|Gbarcode::BARCODE_NO_ASCII
#else
#print_options = Gbarcode::BARCODE_OUT_EPS
#end

##encode the barcode object in desired format
#use a tempfile
#File.open(eps,'wb') do |eps_img| 
#Gbarcode.barcode_print(bc, eps_img, print_options)
#eps_img.close

#convert_to_png(eps, out, options[:resolution], options[:antialias])
#end

#image_tag(out.gsub(/.*public\/system/, '/system'))
#end
#end

#def qrcode(string, options = {})
#output_format = 'png'
#string.downcase!

## This gives us a partitioned path so as not to have thousands
## of files in the same directory.  Also, put the files in
#path = Rails.root.join('public', 'system', 'qrcodes', *Digest::MD5.hexdigest(string).first(9).scan(/.../))
#FileUtils.mkdir_p(path)
#out = "#{path}/#{string}.#{output_format}"

##dont generate a barcode image again, if already generated
#unless File.exists?(out)
##generate the barcode object with all supplied options
#qrcode = QREncoder.encode(string)

##create the png image
#png = qrcode.png(options)
#png.save(out)
#end

##send the html image tag
#image_tag(out, :alt => "qrcode #{string}")
#end

#end


module ImageMagickWrapper
# call imagemagick library on commandline thus bypassing RMagick
# memory leak hasseles :)
def convert_to_png(src, out, resolution=nil, antialias=nil)
#more options : convert +antialias -density 150 eps png
options = []
if resolution.present?
options << "-density #{resolution}"
elsif antialias == 1
options << "+antialias"
end

system("convert #{options.join(' ')} #{src} #{out}")
end
end

