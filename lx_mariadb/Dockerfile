FROM mariadb:10.3

LABEL   name="Loftux Alfresco Tomcat 8 Base" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Simple Image that bootstraps an Alfresco database and adds custom configuration"

COPY setupalfrescodb.sql /docker-entrypoint-initdb.d/
COPY alfrescoconf.cnf /etc/mysql/conf.d/