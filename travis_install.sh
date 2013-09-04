#!/bin/sh

set -x
set -e

sudo apt-get update
sudo apt-get remove postgresql-9.1
sudo apt-get install -qq build-essential flex autoconf libtool gfortran postgresql-server-dev-all xsltproc libjson0-dev libproj-dev dblatex xsltproc libcunit1-dev libcunit1 docbook-xsl docbook-mathml

export LSB_RELEASE=$( lsb_release -rs )

wget -q http://stardestroyer.de/travis/geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz
tar xzf geos-$GEOS_VERSION.travis.$LSB_RELEASE.tar.gz -C /

wget -q http://stardestroyer.de/travis/gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz
tar xzf gdal-$GDAL_VERSION.travis.$LSB_RELEASE.tar.gz -C / 

wget -q http://stardestroyer.de/travis/postgresql-$POSTGRES_VERSION.travis.$LSB_RELEASE.tar.gz
tar xzf postgresql-$POSTGRES_VERSION.travis.$LSB_RELEASE.tar.gz -C / 
