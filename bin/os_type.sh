#!/bin/bash

lowercase() {
  echo "$1" | awk '{print tolower($0)}'
}

OS=`lowercase \`uname\``  # i.e. - linux
KERNEL=`uname -r`
MACH=`uname -m`
DistroBasedOn='null'

if [ $OS = "windowsnt" ]; then
  OS=windows
elif [ $OS = "darwin" ]; then
  OS=mac
else
  OS=`uname`
  if [ $OS = "Linux" ]; then
    if [ -f /etc/redhat-release ]; then
      DistroBasedOn='redhat'
    elif [ -f /etc/SuSE-release ]; then
      DistroBasedOn='suse'
    elif [ -f /etc/mandrake-release ]; then
      DistroBasedOn='mandrake'
    elif [ -f /etc/debian_version ]; then
      DistroBasedOn='debian'
    fi

    OS=`lowercase $OS`
  fi
fi

is_osx(){
  [ $OS = Darwin ]
}

is_redhat() {
  [ $DistroBasedOn = redhat ]
}

is_centos() {
  [ $DistroBasedOn = redhat ]
}

is_ubuntu() {
  [ $DistroBasedOn = debian ]
}

is_debian() {
  [ $DistroBasedOn = debian ]
}
