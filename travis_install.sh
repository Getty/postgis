#!/bin/sh

set +x

export LSB_RELEASE=$( lsb_release -rs )

wget -q http://stardestroyer.de/travis/geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz
tar xvzf geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz -C / 
sudo ln -s /home/travis/geos-$GEOS_VERSION/lib/libgeos_c.so.1.8.0 /usr/lib/libgeos_c.so.1
wget -q http://stardestroyer.de/travis/gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz
tar xvzf gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz -C / 
LD_LIBRARY_PATH="/home/travis/geos-$GEOS_VERSION/lib:/home/travis/gdal-$GDAL_VERSION/lib"
./configure --with-geosconfig=/home/travis/geos-$GEOS_VERSION/bin/geos-config --with-gdalconfig=/home/travis/gdal-$GDAL_VERSION/bin/gdal-config
