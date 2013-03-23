# MultiEncoder

QRcode and Barcode printing for Rails apps. Saves png's to the filesystem or
as3.

## Installation

Build the C library lib <tt>111qrcode.a</tt> available [here] (http://megaui.net/fukuchi/works/qrencode/index.en.html).

    curl http://fukuchi.org/works/qrencode/qrencode-3.2.0.tar.gz | tar xz
    cd qrencode-3.2.0
    ./configure
    make
    sudo make install

Add this line to your application's Gemfile:

    gem 'multi_encoder', path: 'path/to/repo'

or, if you upload the source to github:

    gem 'multi_encoder', github: 'alce/multi_encoder'

And then execute:

    $ bundle

This will compile the gbarcode extension, included within.

## Usage

The public api did not change:

    <%= qrcode 'whasupbro' %>
    <%= barcode 'notmuchmate' height: 20, width: 400, xoff: 10, yoff: 10 %>

## Configuration

There is nothing to configure if you want the resulting png's saved to
the filesystem. This is the default. If you want to upload the images ot
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

    boletia-development-barcodes
    boletia-development-qrcodes
    boletia-production-barcodes

and so on.


## TODO

The gem is still somewhat unstable. It should work without much trouble
in your dev machine and current boletia's servers. Maybe all that's
needed is some path tweaking, depending on how capistrano symlinks your
stuff.

I still need to do some exploratory testing on Heroku.

That's it, I think.
