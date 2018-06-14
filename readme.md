![](https://loftux.com/files/static/images/lxcommunity_ecm_logo.png)

# Loftux AB - Alfresco Docker Images
This is a set of Docker Images provided as a set of sample images for an Alfresco Docker setup.  

None of the images are currently published to a publice registry, if you clone this project you will be able to do a local build and run this with the provided docker-compose file in folder lx_runner. If you do build and run, the default is to use LXCommunity ECM, and you can evaluate, or just continue to use. If you want commercial support, please contact us via https://loftux.se/en/contact.

NOTE: You must understand how to run Docker, and understand data persistance, and how to do backups. If you don't, do not use this in with any sensitive data. 

# Provided Docker images
The project comes with a complete set of Docker files that can be built and run Alfresco. Just run the `buildall.sh` shell script. You can customize the build script to use your own custom tags as needed.  

Below is a brief overview of each image. If you are looking at running custom Alfresco version, it is the Dockerfile in `lx_corp_alfresco` and `lx_corp_share` that needs customization first.

## lx_debian_tomcatbase
This is the base image that is customized to run Tomcat 8 with features needed for Alfresco, primarily adding `/opt/alfresco/tomcat/shared`. It has a custom startupscript that will check if any configuration files exist in `/opt/alfresco/tomcat/shared`, if not copy from `/opt/alfresco/tomcat/shareddefault` (to which there are files added in images based on this image) to populate the default settings/overrides to Alfresco.  

It also prepares to run with user `alfresco` so that the container does not have to run as root.

**ENV**  
When running you docker instances, override these ENV variables to use custom settings. TOMCAT_MEM is using an experimental feature of Java8 to automatically detect available memory in a container. You can replace with thraditional xms, xmx as needed.  

    TOMCAT_MEM="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap" \
    TOMCAT_REGION="-Duser.country=US -Duser.region=US -Duser.language=en -Duser.timezone=\"Europe/Stockholm\"" \
  
**VOLUMES**  
`/opt/alfresco/alf_data` - Mount for access to Alfresco content store.  
`/opt/alfresco/tomcat/shared` - Mount for to tomcat shared.

## lx_debian_alfbase
This image adds Libreoffice, Imagemagick, Alfresco PDF Renderer, JDBC drivers and other dependencies needed to run Alfresco Repository (Alfresco Platform). It is currently one monlithic image, and quite large (ca 1.1GB). We may later try to break out running components such as LibreOffice in separate containers.  

NOTE: The included alfresco-global.properties is customized to fit the latest version of LXCommunity ECM that has JodConverter support. You need to change this in order to run LibreOffice with an older version of Alfreco.

## lx_corp_alfresco
This is image extends from `lx_debian_alfbase` and adds the final alfresco.war. In the default setup it downloads and expands via curl, but you can easily change this to copy a local alfresco.war with all your customizations instead. IF you need a custom alfresco-global.properties, you can override the one included from lx_debian_alfbase by adding `COPY alfresco-global.properties ${CATALINA_HOME}/shareddefault/classes/` to the Dockerfile.     
*If you do customize, we recommend you change the buildall.sh script to use a custom tag.*

The folder corporatefonts can be used to add custom fonts that is used by your organization to get better results for LibreOffice transformations/previews.

## lx_corp_share
This is image extends from `lx_debian_tomcatbase` and adds the final share.war and share-custom-config configurations. In the default setup it downloads and expands via curl, but you can easily change this to copy a local alfresco.war with all your customizations instead.  
*If you do customize, we recommend you change the buildall.sh script to use a custom tag.*

## lx_alfresco_search
This image runs Alfresco Search Services, Solr6. Extends from Alpine docker image.

**VOLUMES**  
`/opt/alfresco-search-services/data` - The index data.  
`/opt/alfresco-search-services/solrhome/alfresco`- Alfresco core, add custom settings here.  
`/opt/alfresco-search-services/solrhome/archive` - Archive core, add custom settings here.  


## lx_mariadb
This image just adds a default database `alfresco` to the first instance. It also adds some custom configurations to increase number of allowed connections. Since it is based on default mariadb, see https://hub.docker.com/_/mariadb/ for other options.

## lx_nginx
This image acts as proxy to the running share containers. On first startup, it adds the default configuration to `/etc/nginx/conf.d`.  
It is based on standard nginx image, more options here https://hub.docker.com/_/nginx/.

**VOLUMES**  
`/etc/nginx/ssl` - Add ssl certificates here.  
`/etc/nginx/conf.d` - Nginx configuration. Includes a sample ssl config that can be used to add ssl support.  

## lx_runner
This is a sample docker-compose file to start up the containers. Most important from this sample is how you can mount volumes so that important data is stored outside of the running container. It also makes sure that exposed ports are only available to the Docker server localhost, only nginx ports is availble outside localhost.
