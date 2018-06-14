FROM openjdk:8-alpine

LABEL   name="Loftux Alfresco Search Services" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Alfresco Search Services - Alpine based image customized to be used with Alfresco Content Platform"
        
ENV SOLR_DIR=/opt/alfresco-search-services \
    SOLR_JAVA_MEM="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"

RUN set -ex && \
    addgroup -g 998 -S solr && \
    adduser -u 998 -h $SOLR_DIR -S solr -H /bin/bash -G solr && \
    apk --no-cache -U upgrade && \
    apk --no-cache add curl ca-certificates bash procps unzip openssl && \
    curl -# -L -O https://downloads.loftux.net/public/content/org/alfresco/alfresco-search-services/1.1.1/alfresco-search-services-1.1.1.zip && \
    unzip alfresco-search-services-1.1.1.zip -d /opt/ && rm alfresco-search-services-1.1.1.zip && \
    mkdir -p $SOLR_DIR/data && \
    mv $SOLR_DIR/solrhome/alfrescoModels $SOLR_DIR/data/ && \
    chown -R solr:solr $SOLR_DIR && \
    rm -rf /tmp/* /var/cache/apk/*

COPY shared.properties $SOLR_DIR/solrhome/conf/

RUN echo '#Docker Setup' >> $SOLR_DIR/solr.in.sh && \
    echo 'SOLR_OPTS="$SOLR_OPTS -Dsolr.data.dir.root=/opt/alfresco-search-services/data -Dsolr.solr.model.dir=/opt/alfresco-search-services/data/alfrescoModels"' >> $SOLR_DIR/solr.in.sh

RUN ls -al /opt/alfresco-search-services/solr/bin/

VOLUME  /opt/alfresco-search-services/solrhome/alfresco \
        /opt/alfresco-search-services/solrhome/archive \
        /opt/alfresco-search-services/data

EXPOSE 8983/tcp

USER solr

CMD ["/bin/bash", "/opt/alfresco-search-services/solr/bin/solr", "start", "-f"]