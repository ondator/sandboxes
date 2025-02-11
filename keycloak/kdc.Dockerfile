FROM osixia/light-baseimage:1.3.3
RUN sed -i '/buster-backports/d' ./etc/apt/sources.list \
&& apt update && DEBIAN_FRONTEND=noninteractive  apt install -y krb5*

ADD service /container/service

EXPOSE 88 750
# RUN dpkg-reconfigure krb5-config