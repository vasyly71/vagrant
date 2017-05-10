# Packer templates for vagrant boxes

[![Build Status](http://img.shields.io/travis/chef/bento.svg)][travis]

This project containes [Packer](https://www.packer.io/) templates for building [Vagrant](https://www.vagrantup.com/) base boxes. 

## Pre-built Boxes

The following boxes are built from this repository's templates:
  - centos-7.3-x86_64-nfs - basic nfs server
  - centos-7.3-x86_64-ucp - basic centos with everything required to install docker UCP.

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/) (if you want to build the VirtualBox box)

Make sure all the required software (listed above) is installed, then cd to the directory containing this README.md file, and run:

    $ packer build centos-7.3-x86_64-nfs

or

    $ packer build centos-7.3-x86_64-nfs

After a few minutes, Packer should tell you the box was generated successfully.

## Testing built boxes

Boxes were tested using vagrant 1.9.3 and virtual box  5.1.22.

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From this same directory, run one of the following commands after building the boxes:

    # For VirtualBox:
    $ vagrant up virtualbox --provider=virtualbox

## License

MIT license.

