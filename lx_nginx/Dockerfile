FROM nginx:1.15-alpine

LABEL   name="Loftux Alfresco Tomcat 8 Base" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Nginx Front end customized as a Proxy for Alfresco containers"

COPY copy_to_image /copy_to_image

RUN rm /etc/nginx/conf.d/* && \
    mv /copy_to_image/nginx.conf /etc/nginx/ && \
    mkdir -p /etc/nginx/conf.d-default && \
    mv /copy_to_image/alfresco.conf /etc/nginx/conf.d-default/ && \
    mv /copy_to_image/alfresco.conf.ssl /etc/nginx/conf.d-default/ && \
    mv /copy_to_image/basic-settings.conf /etc/nginx/conf.d-default/ && \
    mv /copy_to_image/startup.sh /etc/nginx/startup.sh && \
    chmod 550 /etc/nginx/startup.sh && \
    rm -r /copy_to_image && \
    apk --no-cache add bash && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 80
EXPOSE 443

VOLUME  /etc/nginx/ssl \
        /etc/nginx/conf.d

CMD ["/bin/bash", "/etc/nginx/startup.sh"]