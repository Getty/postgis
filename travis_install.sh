#!/bin/sh

REPO_DIR=$( pwd )

set -x

export LSB_RELEASE=$( lsb_release -rs )
export LD_LIBRARY_PATH="/home/travis/geos-$GEOS_VERSION/lib:/home/travis/gdal-$GDAL_VERSION/lib"

wget -q http://stardestroyer.de/travis/geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz
tar xvzf geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz -C /
wget -q http://stardestroyer.de/travis/gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz
tar xvzf gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz -C / 

cd $REPO_DIR

./configure --with-geosconfig=/home/travis/geos-$GEOS_VERSION/bin/geos-config --with-gdalconfig=/home/travis/gdal-$GDAL_VERSION/bin/gdal-config
