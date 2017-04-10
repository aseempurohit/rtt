FROM  phusion/baseimage:0.9.19

ENV http_proxy http://165.225.104.34:80
ENV https_proxy https://165.225.104.34:80

RUN apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
    rm -rf /var/cache/oracle-jdk${JAVA_VER}-installer

RUN update-java-alternatives -s java-8-oracle

RUN wget --no-check-certificate https://apertium.projectjj.com/apt/install-release.sh
RUN chmod +x install-release.sh
RUN ./install-release.sh

RUN wget --no-check-certificate https://apertium.projectjj.com/apt/install-nightly.sh
RUN chmod +x install-nightly.sh
RUN ./install-nightly.sh

RUN apt-get install -y --allow-unauthenticated apertium-all-dev
RUN apt-get install -y --allow-unauthenticated apertium-eng-deu
RUN apt-get install -y --allow-unauthenticated apertium-mk-en
RUN apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
RUN apt-get install -y libstdc++6
RUN apt-get install -y build-essential python3-dev python3-pip zlib1g-dev subversion
RUN pip3 install --trusted-host pypi.python.org --upgrade tornado

RUN PYTHONPATH="/usr/local/lib/python3.3/site-packages:${PYTHONPATH}"; export PYTHONPATH
RUN dpkg-reconfigure locales

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /home

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV API_MANAGER_HOST wso2apim
ENV OCR_SERVICE_HOST_NAME localhost
ENV OCR_SERVICE_PORT_NUMBER 4898
ENV TRANSLATION_SERVICE_HOST_NAME localhost
ENV TRANSLATION_SERVICE_PORT_NUMBER 4897
ENV API_MANAGER_HOST wso2apim
ENV TESSDATA_PREFIX /home/
ENV SKIP_API_REGISTRATION true

EXPOSE 4898
EXPOSE 4899
EXPOSE 4897

ADD target/Cloudlet-0.0.1-SNAPSHOT.jar .
ADD target/libopencv_highgui.so.2.4.13 .
ADD target/libopencv_core.so.2.4.13 .
ADD target/libopencv_imgproc.so.2.4.13 .
ADD target/TextDetector.so .
ADD msf4j-http-config.yaml .
ADD src/main/resources/launchCloudletApp.sh .
RUN chmod +x launchCloudletApp.sh
ADD tessdata/ ./tessdata
ADD target/tesseract-ocr-service-1.0-SNAPSHOT.jar .
ADD msf4j-http-config.yaml .
ADD src/main/resources/launchService.sh .
RUN chmod +x launchService.sh
ADD apertium-apy ./apertium-apy
RUN cd apertium-apy && chmod +x servlet.py
ADD runapertium.sh .
RUN chmod +x runapertium.sh
ADD temp.yaml .
ADD final.sh .
RUN chmod +x final.sh

CMD ./final.sh

