#!/bin/sh

mkdir -p $HOME/code/go/{bin,pkg,src}
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | sh
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.10.1
gvm use go1.10.1 --default

go get -u github.com/cweill/gotests/...

curl https://glide.sh/get | sh
