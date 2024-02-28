#!/bin/bash

echo "chmod +x $0 to use it"

if ! command -v wget &> /dev/null && ! command -v curl &> /dev/null; then
    echo "!wget && !curl"
    apt update -y;apt install wget -y || apt install curl -y
fi

ARCH=$(uname -m)

case $ARCH in
    "x86" | "i386" | "amd64")
        URL="https://go.dev/dl/go1.22.0.linux-amd64.tar.gz"
        ;;
    "armv6l")
        URL="https://go.dev/dl/go1.22.0.armv6l.tar.gz"
        ;;
    "arm64")
        URL="https://go.dev/dl/go1.22.0.linux-arm64.tar.gz"
        ;;
    *)
        URL="https://go.dev/dl/go1.22.0.linux-amd64.tar.gz"
        ;;
esac

if command -v wget &> /dev/null; then
    wget $URL
    tar -C /usr/local -xzf ${URL##*/}
elif command -v curl &> /dev/null; then
    curl -O $URL
    tar -C /usr/local -xzf ${URL##*/}
fi

rm -rf /usr/local/go && tar -C /usr/local -xzf ${URL##*/}

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
export PATH=$PATH:/usr/local/go/bin

installed_version_check=$(go version)
echo "Current version of Golang: $installed_version_check"

rm ${URL##*/}
