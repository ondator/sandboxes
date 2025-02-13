#!/bin/bash -e

# Start Kerberos services
mkdir -p /var/log/krb5/

# Start Kerberos services
echo "Starting kadmin..."
kadmind -P /var/run/kadmind.pid 
echo "Starting krb5kdc..."
krb5kdc -P /var/run/krb5kdc.pid

# Show kdc logging as output. Tail will exit when receiving SIGTERM.
tail -f /var/log/krb5/krb5kdc.log &
tail_pid=$!
trap 'kill $tail_pid' TERM INT
wait $tail_pid

# At this point the container is shutting down, so we stop all
# services
echo "Shutting down krb5kdc..."
kill $(cat /var/run/krb5kdc.pid)
echo "Shutting down kadmin..."
kill $(cat /var/run/kadmind.pid)