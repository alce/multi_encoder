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
        MultiEncoder::Storage.configure do |c|
          c.destination = :aws
          c.aws_bucket_prefix = ENV['AWS_BUCKET_PREFIX']
          c.aws_access_key = ENV['AWS_ACCESS_KEY']
          c.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
        end
      end

      after do
        barcode.delete if barcode.exists?
      end

      specify 'exsits? is false' do
        barcode.exists?.should be_false
      end

      it 'saves to as3' do
        barcode.write
        barcode.exists?.should be_true
        barcode.should_not_receive(:write)
        barcode.href.should match(/^http/)
      end
    end
  end
end
