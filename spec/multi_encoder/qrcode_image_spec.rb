require 'spec_helper'

module MultiEncoder

  describe QRcodeImage do

    let(:qrcode) { QRcodeImage.new 'thesisist' }

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
        MultiEncoder::Storage.configure do |c|
          c.destination = :aws
          c.aws_bucket_prefix = ENV['AWS_BUCKET_PREFIX']
          c.aws_access_key = ENV['AWS_ACCESS_KEY']
          c.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
        end
      end

      after do
        qrcode.delete if qrcode.exists?
      end

      specify 'exsits? is false' do
        qrcode.exists?.should be_false
      end

      it 'saves to as3' do
        qrcode.write
        qrcode.exists?.should be_true
        qrcode.should_not_receive(:write)
        qrcode.href.should match(/^http/)
      end
    end
  end
end

