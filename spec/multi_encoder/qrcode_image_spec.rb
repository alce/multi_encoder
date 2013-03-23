require 'spec_helper'

module MultiEncoder

  describe QRcodeImage do

    let(:qrcode) { QRcodeImage.new 'thesisist'}

    context "Filesystem storage" do

      after do
        root_dir = qrcode.root.join 'public'
        FileUtils.rm_rf root_dir if root_dir.exist?
      end

      specify 'exsits? is false' do
        qrcode.exists?.should be_false
      end

      it 'should write the file if href is requested' do
        qrcode.should_receive(:write)
        qrcode.href
      end

      it 'writes the png to the filesystem' do
        qrcode.write
        qrcode.exists?.should be_true
      end

      it 'does not write the png twice' do
        qrcode.write
        qrcode.should_not_receive(:write)
        qrcode.href
      end
    end

    context "AWS storage" do
      before do
        MultiEncoder::Storage.destination = :aws
      end
    end
  end
end

