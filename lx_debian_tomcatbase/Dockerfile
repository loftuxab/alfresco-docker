FROM tomcat:8-jre8

LABEL   name="Loftux Alfresco Tomcat 8 Base" \
        vendor="Loftux AB" \
        url="https://loftux.se/alfresco-docker" \
        vcs-url="https://github.com/loftuxab/alfresco-docker" \
        description="Tomcat 8 Debian based image customized to be used as base image for Alfresco Content Platform"

ENV TOMCAT_MEM="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap" \
    TOMCAT_REGION="-Duser.country=US -Duser.region=US -Duser.language=en -Duser.timezone=\"Europe/Stockholm\"" \
    ALF_HOME=/opt/alfresco \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    apt-utils curl unzip procps && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN mkdir -p ${CATALINA_HOME}/shared && \
    mkdir -p ${CATALINA_HOME}/shareddefault/classes/alfresco/extension && \
    mkdir -p ${CATALINA_HOME}/conf/Catalina/localhost/ && \
    mkdir -p ${CATALINA_HOME}/../modules/platform && \
    mkdir -p ${CATALINA_HOME}/../modules/share && \
    mkdir -p ${ALF_HOME}/alf_data && \
    mkdir -p ${ALF_HOME}/logs && \
    ln -s ${CATALINA_HOME} ${ALF_HOME}/tomcat && \
    ln -s ${CATALINA_HOME}/../modules  ${ALF_HOME}/modules && \
    ln -s ${CATALINA_HOME}/shared  ${ALF_HOME}/shared && \
    rm -rf ${CATALINA_HOME}/webapps/* && \
    sed -i -r -e 's|^shared\.loader=$|shared\.loader="${catalina.base}/shared/classes","${catalina.base}/shared/lib/*.jar"|' ${CATALINA_HOME}/conf/catalina.properties  && \ 
    groupadd -g 999 alfresco && \
    useradd -r -u 999 -g alfresco alfresco && \
    chown -R alfresco:alfresco ${CATALINA_HOME}

COPY startup.sh ${ALF_HOME}/startup.sh
COPY conf/ ${CATALINA_HOME}/conf/

RUN chown -R alfresco:alfresco ${ALF_HOME} && chmod 550 ${ALF_HOME}/startup.sh

#USER alfresco

VOLUME ["/opt/alfresco/alf_data"]
#VOLUME ["/opt/alfresco/modules"]
VOLUME ["/opt/alfresco/tomcat/shared"]

CMD /opt/alfresco/startup.sh    