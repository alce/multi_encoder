require 'spec_helper'

module MultiEncoder

  describe BarcodeImage do

    let(:barcode) { BarcodeImage.new 'thesisist'}

    context "Filesystem storage" do

      after do
        root_dir = barcode.root.join 'public'
        FileUtils.rm_rf root_dir if root_dir.exist?
      end

      specify 'exsits? is false' do
        barcode.exists?.should be_false
      end

      it 'should write the file if href is requested' do
        barcode.should_receive(:write)
        barcode.href
      end

      it 'writes the png to the filesystem' do
        barcode.write
        barcode.exists?.should be_true
      end

      it 'does not write the png twice' do
        barcode.write
        barcode.should_not_receive(:write)
        barcode.href
      end
    end

    context "AWS storage" do
      before do
        MultiEncoder::Storage.destination = :aws
      end
    end
  end
end
