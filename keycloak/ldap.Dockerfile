FROM osixia/openldap:1.5.0
RUN sed -i '/buster-backports/d' ./etc/apt/sources.list \
&& apt update && apt install -y krb5-kdc-ldap \
&& cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /container/service/slapd/assets/config/bootstrap/schema \
&& gunzip /container/service/slapd/assets/config/bootstrap/schema/kerberos.schema.gz
# RUN dpkg-reconfigure krb5-config