#!/bin/sh
VERSION=1
#AVAIL_VERSION=`curl -s http://kb.completelydedicated.com/e1000update.version.php`
AVAIL_VERSION=1
if [ "$VERSION" != "$AVAIL_VERSION" ]; then
	echo "    A newer version of this script is available for download."
	echo "    wget http://kb.completelydedicated.com/download/e1000update.sh"
	exit 127	
fi

if [ $# -ne 1 ]; then
  echo Usage:  ./e1000update.sh {kernel version}
  if [ -d /lib/modules ]; then
    echo "    Possible kernel versions:"
    echo "    "`ls /lib/modules/`
  fi
  echo ""
else
  if [ -d /lib/modules/$1 ]; then
    if [ -f /etc/redhat-release ] ; then
      DIST='redhat'
    elif [ "`cat /etc/issue | grep Ubuntu`" != "" ]   ; then
      DIST='ubuntu'
    elif [ -f /etc/debian_version ] ; then
      DIST='debian'
    elif [ -f /etc/fedora-release ] ; then
      DIST='fedora'
    fi

    # make sure we have build tools and kernel headers
    if [ "$DIST" = "redhat" ] || [ "$DIST" = "fedora" ] ; then
      yum -y install gcc kernel-smp-devel
      yum -y install kernel-devel
      yum -y update kernel-devel
      yum -y update kernel-smp-devel
    elif [ "$DIST" = "debian" ] ; then
      apt-get -y update
      apt-get -y install make gcc linux-headers-2.6-686
    elif [ "$DIST" = "ubuntu" ] ; then
      apt-get -y update
      apt-get -y install make gcc
      apt-get -y install -t $1 linux-source
      apt-get -y install linux-headers-$1
      # The linux source is in a tar file we will need to extract it
      # We need to extract /usr/src/*.tar.bz2
      cd /usr/src
      for I in *tar.bz2
      do
	tar -xzf $I
      done
    fi

    if [ $DIST ] ; then
      cd /tmp
      wget http://kb.completelydedicated.com/download/e1000-7.6.15.4.tar.gz
      tar -xzf e1000-7.6.15.4.tar.gz
      cd e1000-7.6.15.4/src
      make BUILD_KERNEL=$1
      make install BUILD_KERNEL=$1
    else
      echo "Sorry this script does not work for the distribution you are running"
    fi
  else
    echo Error: Kernel $1 does not exist
    if [ -d /lib/modules ]; then
      echo "    Possible kernel versions:"
      echo "    "`ls /lib/modules/`
    fi
    echo ""
  fi
fi
