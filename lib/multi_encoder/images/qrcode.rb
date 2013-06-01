module MultiEncoder
  class QRcodeImage < AbstractImage

    def type
      'qrcodes'
    end

    def write
      qrcode = QREncoder.encode @contents.downcase
      png = qrcode.png @options
      FileUtils.mkdir_p directory
      png.save file_path unless file_path.exists?
      save if respond_to? :save
    end
  end
end
