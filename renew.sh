#! /bin/sh
set -e
echo "Running renew script"
lego --dns="${DNS_PROVIDER}" \
 --email=${EMAIL} --domains="${DOMAIN_NAME}" --domains="*.${DOMAIN_NAME}" \
 --dns.disable-cp -a renew --days 30 --renew-hook=/usr/local/bin/secret.sh