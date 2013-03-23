require 'spec_helper'

module MultiEncoder

  describe BarcodeImage do
    describe "Filesystem storage" do
      let(:barcode) { BarcodeImage.new 'thisisist' }

      after do
        file = barcode.file_path
        FileUtils.rm file if file.exist?
      end

      context "When the image does not exist" do
        specify 'exsits? is false' do
          barcode.exists?.should be_false
        end

        it 'should write the file if href is requested' do
          barcode.should_receive(:write)
          barcode.href
        end

        it 'writes the png to the filesystem' do
          barcode.exists?.should be_false
          barcode.write
          barcode.exists?.should be_true
        end
      end

      context "When the image exsits" do
        before(:all) do
          @barcode = BarcodeImage.new 'guesswhat'
          @barcode.write
        end

        after(:all) do
          file = @barcode.file_path
          FileUtils.rm file if file.exist?
        end

        specify 'exsits? is true' do
          @barcode.exists?.should be_true
        end

        it 'does not write the png' do
          @barcode.should_not_receive(:write)
          @barcode.href
        end
      end
    end








    context "AWS storage" do
      before do
        MultiEncoder::Storage.destination = :aws
      end

      it 'whatever' do
        Array.new.should be_empty
      end
    end
  end
end
