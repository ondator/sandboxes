#!/bin/bash -e
FIRST_START_DONE="${CONTAINER_STATE_DIR}/krb5-first-start-done"

# container first start
if [ ! -e "$FIRST_START_DONE" ]; then
  kdb5_ldap_util -D cn=admin,dc=example,dc=org create -subtrees ou=people,dc=example,dc=org -sscope sub -r EXAMPLE.ORG -s -H ldap://ldap -P password -w admin
  kdb5_ldap_util -D cn=admin,dc=example,dc=org stashsrvpw -f /etc/krb5kdc/service.keyfile uid=kdc-service,dc=example,dc=org -w admin << EOL
password
password
EOL

  kdb5_ldap_util -D cn=admin,dc=example,dc=org stashsrvpw -f /etc/krb5kdc/service.keyfile uid=kadmin-service,dc=example,dc=org -w admin << EOL
password
password
EOL

  touch $FIRST_START_DONE
fi

exit 0