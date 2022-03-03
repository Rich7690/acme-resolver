#! /bin/sh
set -e

echo "Updating secret"
kubectl create secret tls prod-cert \
--cert=/data/.lego/certificates/${DOMAIN_NAME}.crt \
--key=/data/.lego/certificates/${DOMAIN_NAME}.key --save-config --dry-run=client -o yaml | kubectl apply -n default -f -