FROM loftux/lx_tomcatbase:latest

LABEL   name="Loftux Alfresco Corporate Image" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Image to use as final Alfresco Share run container, customized to your needs"

# ADD share.war $CATALINA_HOME/webapps/share.war
# RUN mkdir $CATALINA_HOME/webapps/share && cd $CATALINA_HOME/webapps/share && unzip $CATALINA_HOME/webapps/share.war && rm -f $CATALINA_HOME/webapps/share.war && \
#     #chmod -R =r $CATALINA_HOME/webapps && \
#     chown -R alfresco:alfresco ${CATALINA_HOME} && \
#     chown -R alfresco:alfresco ${ALF_HOME}


RUN curl -# -L https://downloads.loftux.net/alfresco/share/LX101/share-LX101.war -o $CATALINA_HOME/webapps/share.war && \
    mkdir $CATALINA_HOME/webapps/share && cd $CATALINA_HOME/webapps/share && unzip $CATALINA_HOME/webapps/share.war && rm -f $CATALINA_HOME/webapps/share.war && \  
    mkdir -p $CATALINA_HOME/shareddefault/classes/alfresco/web-extension && \
    chown -R alfresco:alfresco ${CATALINA_HOME} && \
    chown -R alfresco:alfresco ${ALF_HOME}

ADD share-config-custom.xml $CATALINA_HOME/shareddefault/classes/alfresco/web-extension

EXPOSE 8080

USER alfresco