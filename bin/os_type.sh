#!/bin/bash

lowercase(){
  # echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghipqrstuvwxyz/"
  echo "$1" | awk '{print tolower($0)}'
}

OS=`lowercase \`uname\``  # i.e. - linux
KERNEL=`uname -r`
MACH=`uname -m`

if [ "{$OS}" = "windowsnt" ]; then
  OS=windows
elif [ "{$OS}" = "darwin" ]; then
  OS=mac
else
  OS=`uname`
  if [ "${OS}" = "Linux" ] ; then
    if [ -f /etc/redhat-release ] ; then
      DistroBasedOn='RedHat'
    elif [ -f /etc/SuSE-release ] ; then
      DistroBasedOn='SuSe'
    elif [ -f /etc/mandrake-release ] ; then
      DistroBasedOn='Mandrake'
    elif [ -f /etc/debian_version ] ; then
      DistroBasedOn='Debian'
    fi

    OS=`lowercase $OS`
    DistroBasedOn=`lowercase $DistroBasedOn`
    readonly DistroBasedOn # Redhat
    readonly MACH          # x86_64
  fi
fi

is_osx(){ [ OS = Darwin ] }

is_redhat() { [ DistroBasedOn = Redhat ] }
is_centos() { [ DistroBasedOn = Redhat ] }

is_ubuntu() { [ DistroBasedOn = Debian ] }
is_debian() { [ DistroBasedOn = Debian ] }
