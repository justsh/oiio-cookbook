name             "oiio"
maintainer       "Justin Sheehy"
maintainer_email "sys.exit0@gmail.com"
license          "MIT"
description      "Installs OpenImageIO"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports         "ubuntu"

depends 'apt', '~> 2.8.2'
depends 'git', '~> 4.3.4'
depends 'build-essential', '~> 2.2.3'
