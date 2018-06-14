#!/bin/bash
# -------

# Copy default files if default not present. If mounted, it only needs this once and you can setup
if [ "$(ls -A /etc/nginx/conf.d)" ]; then
    echo "** Alfresco Nginx config present **"
else
    echo "** Copying default Alfresco Nginx config **"
    cp -r /etc/nginx/conf.d-default/* /etc/nginx/conf.d/
fi

nginx -g 'daemon off;'