# MultiEncoder

QRcode and Barcode generation for Rails apps. Saves resulting png's to
the filesystem or as3. It includes a C extension that wraps the GNU
Barcode project. For qrcode generation, it uses the [qrcode gem] (http://nycrb.rubyforge.org/qrencoder/), which
in turn, wraps the <tt>libqrencode</tt> C library.

## Installation

If you intend to generate QRCodes, you'll need to compile the C library <tt>libqrencode</tt> available [here] (http://megaui.net/fukuchi/works/qrencode/index.en.html).

    curl http://fukuchi.org/works/qrencode/qrencode-3.2.0.tar.gz | tar xz
    cd qrencode-3.2.0
    ./configure
    make
    sudo make install

You'll also need <tt>ImageMagick</tt> to generate the barcode png's.

Add this line to your application's Gemfile:

    gem 'multi_encoder'

And then execute:

    $ bundle

This will compile the gbarcode extension, included within.

## Usage

    <%= qrcode 'whasupbro' %>
    <%= barcode 'notmuchmate' %>

## Options

### Barcodes

The <tt><%= barcode %></tt> heleper generates a barcode in BARCODE_39
format and accepts the following options:

    width
    height
    scaling_factor
    xoff
    yoff
    margin
   
Example:

    <%= barcode width: 100, height: 30, xoff: 100 %>

The resulting PNG will be saved on the filesystem (or as3) and rendered
into the view.

## Configuration

There is nothing to configure if you want the resulting png's saved to
the filesystem. This is the default. If you want to upload the images to
AS3 you'll need to do 2 things:

First: add this line to <tt>production.rb</tt> or <tt>staging.rb</tt>:

    MultiEncoder::Storage.destination = :aws

If you want all environments to upload to aws, just add it to
<tt>application.rb</tt> or an initializer.

Second: export your AWS credentials as environment variables, like so in
<tt>.bash_profile</tt> or whatever:

    export AWS_ACCESS_KEY="STHSTCHSTHSTHCONT"
    export AWS_SECRET_ACCESS_KEY="YI7799xtuAAStEG8hmBGidoQ7hJJeHVEg"

That's it, you are ready to go.

The gem will create buckets with the following names, depending on the
Rails environment:

    multi-encoder-development-barcodes
    multi-encoder-development-qrcodes
    multi-encoder-production-barcodes

and so on.

## Licence

MIT
