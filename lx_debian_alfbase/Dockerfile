FROM loftux/lx_tomcatbase:latest

LABEL   name="Loftux Alfresco Repository Base Image" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Adds Alfresco Repository runtime components for transformations, extends Loftux Alfresco Tomcat base, to be used as base image for Alfresco Content Platform"

RUN echo 'deb http://ftp.de.debian.org/debian stretch main contrib' >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    imagemagick ttf-mscorefonts-installer locales libdbus-glib-1-2 && \
    # Add Alfresco pdfrenderer
    echo "** Install Alfresco pdfrenderer **" && \ 
    curl -# -L https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/alfresco-pdf-renderer/1.1/alfresco-pdf-renderer-1.1-linux.tgz -o ${CATALINA_HOME}/bin/alfresco-pdf-renderer-1.1-linux.tgz; \
    cd ${CATALINA_HOME}/bin && tar xf alfresco-pdf-renderer*.tgz && rm -f ${CATALINA_HOME}/bin/alfresco-pdf-renderer*.tgz && \
    # Add JDBC
    echo "** Install JDBC **" && \ 
    curl -# -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz  -o /tmp/mysql-connector-java.tar.gz && \
    cd /tmp/ && tar xf mysql-connector-java.tar.gz && cd "$(find . -type d -name "mysql-connector*")" && mv mysql-connector*.jar $CATALINA_HOME/lib && rm -rf /tmp/* ; \
    curl -# -L https://downloads.mariadb.com/Connectors/java/connector-java-2.2.5/mariadb-java-client-2.2.5.jar -o $CATALINA_HOME/lib/mariadb-java-client-2.2.5.jar ; \
    # Install Libreoffice
    echo "** Install LibreOffice **" && \ 
    cd /tmp/ && \
    curl -# -L -O http://downloadarchive.documentfoundation.org/libreoffice/old/6.1.0.0.beta1/deb/x86_64/LibreOfficeDev_6.1.0.0.beta1_Linux_x86-64_deb.tar.gz && \
    #curl -# -L -O http://downloadarchive.documentfoundation.org/libreoffice/old/5.4.7.2/deb/x86_64/LibreOffice_5.4.7.2_Linux_x86-64_deb.tar.gz && \
    tar xf LibreOffice*.tar.gz && \
    cd "$(find . -type d -name "LibreOffice*")" && \
    cd DEBS  && \
    rm *gnome-integration*.deb && \
    rm *kde-integration*.deb && \
    rm *debian-menus*.deb && \
    dpkg -i *.deb  && \
    # Touch file so that Alfresco detects correct version - startup commands
    touch /opt/libreofficedev6.1/ure-link ; \
    #touch /opt/libreoffice5.4/ure-link ; \
    # Cleanup
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY alfresco.xml ${CATALINA_HOME}/conf/Catalina/localhost/
COPY alfresco-global.properties ${CATALINA_HOME}/shareddefault/classes/