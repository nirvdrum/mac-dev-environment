#!/bin/bash

# Copyright 2009 Kevin J. Menard Jr.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export EPREFIX="$HOME/Gentoo"
export PATH="$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH"

echo "Unmasking packages that are safe to install"

echo 'media-gfx/imagemagick **' >> $EPREFIX/etc/portage/package.keywords
echo 'virtual/ghostscript **' >> $EPREFIX/etc/portage/package.keywords
echo 'app-text/ghostscript-gpl **' >> $EPREFIX/etc/portage/package.keywords
echo 'net-misc/memcached **' >> $EPREFIX/etc/portage/package.keywords
echo 'dev-libs/libevent **' >> $EPREFIX/etc/portage/package.keywords
echo 'sys-apps/ack **' >> $EPREFIX/etc/portage/package.keywords
echo 'dev-perl/File-Next **' >> $EPREFIX/etc/portage/package.keywords
echo 'virtual/perl-Test-Simple **' >> $EPREFIX/etc/portage/package.keywords
echo 'perl-core/Test-Simple **' >> $EPREFIX/etc/portage/package.keywords
echo 'app-text/dos2unix **' >> $EPREFIX/etc/portage/package.keywords

echo "Installing ruby"
emerge ruby
emerge rubygems

echo "Installing version control tools"
emerge subversion
emerge swig
emerge git

echo "Installing dev tools"
emerge ack
emerge dos2unix
emerge gnupg
emerge memcached

echo "Installing ImageMagick"
emerge ghostscript
emerge imagemagick

echo "Working around a bug with ImageMagick in prefixed environments"
mkdir -p $EPREFIX/usr/lib/ImageMagick-6.5.2/config/usr/share/fonts
ln -s $EPREFIX/usr/share/fonts/corefonts $EPREFIX/usr/lib/ImageMagick-6.5.2/config/usr/share/fonts/corefonts