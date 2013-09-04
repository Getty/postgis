#!/bin/sh

REPO_DIR=$( pwd )

set -x
set -e

export GEOS_PATH="/home/travis/geos-${GEOS_VERSION}"
export PATH="${GEOS_PATH}/bin:$PATH"
export LD_LIBRARY_PATH="${GEOS_PATH}/lib"

export GDAL_PATH="/home/travis/gdal-${GDAL_VERSION}"
export PATH="${GDAL_PATH}/bin:$PATH"
export LD_LIBRARY_PATH="${GDAL_PATH}/lib:$LD_LIBRARY_PATH"

export POSTGRES_PATH="/home/travis/postgresql-${POSTGRES_VERSION}"
export PATH="${POSTGRES_PATH}/bin:$PATH"
export LD_LIBRARY_PATH="${POSTGRES_PATH}/lib:$LD_LIBRARY_PATH"

export PGDATABASE="travis"
export PGUSER="travis"
export PGLOCALEDIR="${POSTGRES_PATH}/share/locale"
export PGDATA="${POSTGRES_PATH}/data"

set

mkdir $PGDATA

initdb --locale=en_US.UTF-8 --encoding=UNICODE

echo "unix_socket_directory=${PGDATA}\n" >>$PGDATA/postgresql.conf
echo "unix_socket_permissions=0777\n" >>$PGDATA/postgresql.conf

cat $PGDATA/postgresql.conf

$POSTGRES_PATH/bin/pg_ctl -l logfile start

sleep 10

cd $REPO_DIR

./autogen.sh
./configure \
  --with-geosconfig=/home/travis/geos-$GEOS_VERSION/bin/geos-config \
  --with-gdalconfig=/home/travis/gdal-$GDAL_VERSION/bin/gdal-config \
  --with-pgconfig=/home/travis/postgresql-$POSTGRES_VERSION/bin/pg_config

make
make check RUNTESTFLAGS=-v
