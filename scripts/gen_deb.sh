#!/bin/sh

WORKDIR=$1
PROJECT_NAME=$2
VERSION=`python -c "from py_gui_demo import __version__;print(__version__)"`
DESCRIPTION=`python -c "from py_gui_demo import __description__;print(__description__)"`
LONG_DESCRIPTION=`python -c "from py_gui_demo import __long_description__;print(__long_description__)"`
ARCH="amd64"

rm -rf $WORKDIR/deb/build/$PROJECT_NAME*
# <name>_<version>-<revision>_<architecture>.deb

DEB_NAME=${PROJECT_NAME}_${VERSION}_${ARCH}
echo $DEB_NAME
echo "----"
DEBIAN=$WORKDIR/deb/build/$DEB_NAME/DEBIAN
mkdir -p $DEBIAN
mkdir -p $WORKDIR/deb/build/$DEB_NAME/tmp

cp -v $WORKDIR/dist/* $WORKDIR/deb/build/$DEB_NAME/tmp/

cat <<EOF >$DEBIAN/postinst
#!/bin/sh
echo post >> /tmp/test
pip install /tmp/$PROJECT_NAME-$VERSION-py3-none-any.whl --user
EOF

cat <<EOF >$DEBIAN/preinst
#!/bin/sh
echo pre >> /tmp/test
pip uninstall /tmp/$PROJECT_NAME-$VERSION-py3-none-any.whl
EOF

cat <<EOF >$DEBIAN/control
Package: test
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Maintainer: robobe <test@test.com>
Description: $DESCRIPTION
 $LONG_DESCRIPTION
Depends: python3, python3-pip, python3-tk
EOF


cd deb/build 
chmod 0755 $DEBIAN/postinst
chmod 0755 $DEBIAN/preinst
dpkg-deb --root-owner-group --build $DEB_NAME