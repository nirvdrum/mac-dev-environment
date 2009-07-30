export EPREFIX="$HOME/Gentoo"
export PATH="$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:$PATH"
export CHOST="x86_64-apple-darwin9"

if [ ! -d "$EPREFIX" ]
then
    mkdir -p "$EPREFIX"
fi

echo "Fetching bootstrap script"
curl http://overlays.gentoo.org/proj/alt/browser/trunk/prefix-overlay/scripts/bootstrap-prefix.sh?format=txt -O ./bootstrap-prefix.sh
chmod 755 ./bootstrap-prefix.sh

echo "Bootstrapping prefixed portage"
./bootstrap-prefix.sh $EPREFIX tree
./bootstrap-prefix.sh $EPREFIX/tmp make
./bootstrap-prefix.sh $EPREFIX/tmp wget
./bootstrap-prefix.sh $EPREFIX/tmp sed
./bootstrap-prefix.sh $EPREFIX/tmp python
./bootstrap-prefix.sh $EPREFIX/tmp coreutils6
./bootstrap-prefix.sh $EPREFIX/tmp findutils
./bootstrap-prefix.sh $EPREFIX/tmp tar15
./bootstrap-prefix.sh $EPREFIX/tmp patch9
./bootstrap-prefix.sh $EPREFIX/tmp grep
./bootstrap-prefix.sh $EPREFIX/tmp gawk
./bootstrap-prefix.sh $EPREFIX/tmp bash
./bootstrap-prefix.sh $EPREFIX portage

export LDFLAGS="-Wl,-search_paths_first -L${EPREFIX}/usr/lib -L${EPREFIX}/lib"
export CPPFLAGS="-I${EPREFIX}/usr/include"
export CC="gcc -m64"
export CXX="g++ -m64"
export HOSTCC="gcc -m64"
hash -r

echo "Building tools required to bootstrap"
emerge --oneshot sed
emerge --oneshot pax-utils
emerge --oneshot --nodeps wget
emerge --oneshot bash
emerge --oneshot --nodeps baselayout-prefix
emerge --oneshot --nodeps lzma-utils
emerge --oneshot --nodeps m4
emerge --oneshot --nodeps flex
emerge --oneshot --nodeps bison
emerge --oneshot --nodeps binutils-config
emerge --oneshot --nodeps binutils-apple
emerge --oneshot --nodeps gcc-config
emerge --oneshot --nodeps gcc-apple

unset LDFLAGS CPPFLAGS CHOST CC CXX HOSTCC

echo "Building core tools"
emerge --oneshot coreutils
emerge --oneshot findutils
emerge --oneshot tar
emerge --oneshot grep
emerge --oneshot patch
emerge --oneshot gawk
emerge --oneshot make
emerge --oneshot --nodeps file
emerge --oneshot --nodeps eselect

echo "Replacing bootstrapped portage with properly built one"
env FEATURES="-collision-protect" emerge --oneshot portage
rm -Rf $EPREFIX/tmp/*
hash -r

echo "Building packages to complete system install"
emerge --sync
emerge -u system

echo 'USE="unicode nls"' >> $EPREFIX/etc/make.conf
echo 'CFLAGS="-O2 -pipe <my-cpu-flags>"' >> $EPREFIX/etc/make.conf
echo 'CXXFLAGS="${CFLAGS}"' >> $EPREFIX/etc/make.conf

echo "Rebuilding system with locally installed tools"
emerge -e system

echo "Cleaning up after install"
rm ./bootstrap-prefix.sh







