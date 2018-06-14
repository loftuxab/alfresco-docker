#!/bin/bash
set -e

REPOSITORY=loftux
VERSION=0.0.1

# cd loftux_javabase
# docker build --compress -t $REPOSITORY/javabase:$VERSION -t $REPOSITORY/javabase:latest .
# cd ..

echo
echo "*********** Building lx_debian_tomcatbase ***********"
echo 

cd lx_debian_tomcatbase
docker build --compress -t $REPOSITORY/lx_tomcatbase:$VERSION -t $REPOSITORY/lx_tomcatbase:latest .
cd ..

echo
echo "*********** Building lx_debian_alfbase ***********"
echo 

cd lx_debian_alfbase
docker build --compress -t $REPOSITORY/lx_alfbase:$VERSION -t $REPOSITORY/lx_alfbase:latest .
cd ..

echo
echo "*********** Building lx_corp_alfresco ***********"
echo 

cd lx_corp_alfresco
docker build --compress -t $REPOSITORY/lx_corpalf:$VERSION -t $REPOSITORY/lx_corpalf:latest .
cd ..

echo
echo "*********** Building lx_corp_share ***********"
echo 

cd lx_corp_share
docker build --compress -t $REPOSITORY/lx_corpshare:$VERSION -t $REPOSITORY/lx_corpshare:latest .
cd ..

echo
echo "*********** Building lx_mariadb ***********"
echo 

cd lx_mariadb
docker build --compress -t $REPOSITORY/lx_mariadb:$VERSION -t $REPOSITORY/lx_mariadb_source:10.3 -t $REPOSITORY/lx_mariadb:latest .
cd ..

echo
echo "*********** Building lx_alfresco_search ***********"
echo 

cd lx_alfresco_search
docker build --compress -t $REPOSITORY/lx_alfresco_search_source:1.1.1 -t $REPOSITORY/lx_alfresco_search:$VERSION -t $REPOSITORY/lx_alfresco_search:latest .
cd ..

echo
echo "*********** Building lx_nginx ***********"
echo 

cd lx_nginx
docker build --compress -t $REPOSITORY/lx_alfresco_nginx_source:1.15 -t $REPOSITORY/lx_alfresco_nginx:$VERSION -t $REPOSITORY/lx_alfresco_nginx:latest .
cd ..

#cd corp_sharebox
#docker build --compress -t $REPOSITORY/corpsharebox:$VERSION -t $REPOSITORY/corpsharebox:latest .
#cd ..

echo
echo "*********** Build Complete *************************************"
echo 