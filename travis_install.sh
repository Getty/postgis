#!/bin/sh

REPO_DIR=$( pwd )

set -x

sudo apt-get update
sudo apt-get remove postgresql-9.1
sudo apt-get install -qq build-essential flex autoconf libtool gfortran postgresql-server-dev-all xsltproc libjson0-dev libproj-dev dblatex xsltproc libcunit1-dev libcunit1 docbook-xsl docbook-mathml

export LSB_RELEASE=$( lsb_release -rs )

export GEOS_PATH="/home/travis/geos-$GEOS_VERSION"
export PATH="$GEOS_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$GEOS_PATH/lib"

export GDAL_PATH="/home/travis/gdal-$GDAL_VERSION"
export PATH="$GDAL_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$GDAL_PATH/lib:$LD_LIBRARY_PATH"

export POSTGRES_PATH="/home/travis/postgresql-$POSTGRES_VERSION"
export PATH="$POSTGRES_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$POSTGRES_PATH/lib:$LD_LIBRARY_PATH"
export PGDATABASE=travis
export PGUSER=travis
export PGLOCALEDIR="${POSTGRES_PATH}/share/locale"

set

$POSTGRES_PATH/bin/postmaster & >>/tmp/travis.postgres.$POSTGRES_VERSION.log 2>&1

cd $REPO_DIR

./autogen.sh
./configure \
  --with-geosconfig=/home/travis/geos-$GEOS_VERSION/bin/geos-config \
  --with-gdalconfig=/home/travis/gdal-$GDAL_VERSION/bin/gdal-config
  --with-pgconfig=/home/travis/postgresql-$POSTGRES_VERSION/bin/pg_config
