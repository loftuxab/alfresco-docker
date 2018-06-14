FROM loftux/lx_alfbase:latest

LABEL   name="Loftux Alfresco Corporate Image" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Image to use as final Alfresco Repository run container, customized to your needs"

# Customize this locale settings if you have problem with transformations and locale specific setting such as dates
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

COPY corporatefonts/ /usr/share/fonts/

RUN fc-cache -fv && \
    echo "LC_ALL=$LANG" >> /etc/environment && \
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    echo "LANG=$LANG" > /etc/locale.conf && \
    locale-gen $LANG

# ADD alfresco.war /opt/alfresco/tomcat/webapps/alfresco.war

# RUN mkdir $CATALINA_HOME/webapps/alfresco && cd $CATALINA_HOME/webapps/alfresco && unzip $CATALINA_HOME/webapps/alfresco.war && rm -f $CATALINA_HOME/webapps/alfresco.war && \
#     #chmod -R =r $CATALINA_HOME/webapps && \
#     chown -R alfresco:alfresco ${CATALINA_HOME} && \
#     chown -R alfresco:alfresco ${ALF_HOME}


RUN curl -# -L https://downloads.loftux.net/alfresco/alfresco/LX101/alfresco-LX101.war -o $CATALINA_HOME/webapps/alfresco.war && \ 
    mkdir $CATALINA_HOME/webapps/alfresco && cd $CATALINA_HOME/webapps/alfresco && unzip $CATALINA_HOME/webapps/alfresco.war && rm -f $CATALINA_HOME/webapps/alfresco.war && \
    #chmod -R =r $CATALINA_HOME/webapps && \
    chown -R alfresco:alfresco ${CATALINA_HOME} && \
    chown -R alfresco:alfresco ${ALF_HOME}

EXPOSE 8080

USER alfresco