#!/bin/sh

WORKDIR=$1
PROJECT_NAME=$2
VERSION=$3

rm -rf $WORKDIR/deb/build/test
mkdir -p $WORKDIR/deb/build/$PROJECT_NAME/DEBIAN
mkdir -p $WORKDIR/deb/build/$PROJECT_NAME/tmp

cp -v $WORKDIR/dist/* $WORKDIR/deb/build/$PROJECT_NAME/tmp/

cat <<EOF >>$WORKDIR/deb/build/$PROJECT_NAME/DEBIAN/postinst
#!/bin/sh
echo post >> /tmp/test
pip install /tmp/$PROJECT_NAME-$VERSION-py3-none-any.whl --user
EOF

cat <<EOF >>$WORKDIR/deb/build/$PROJECT_NAME/DEBIAN/preinst
#!/bin/sh
echo pre >> /tmp/test
EOF

cat <<EOF >>$WORKDIR/deb/build/$PROJECT_NAME/DEBIAN/control
Package: $PROJECT_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Maintainer: robobe <test@test.com>
Description: Python GUI application base on PySimpleGui
Depends: python3, python3-pip, python3-tk
EOF