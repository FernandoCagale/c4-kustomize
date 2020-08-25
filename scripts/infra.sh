#!/usr/bin/env bash

set -e

SINCE=$1
if [[ -z "$SINCE" ]]
then
    SINCE="10m"
fi

function run {
    echo "$(tput setaf 2)$1$(tput sgr0)"
    eval $1
}

run "helm install mongo-order bitnami/mongodb \
    --set="auth.rootPassword=root-password" \
    --set="auth.username=admin" \
    --set="auth.password=admin" \
    --set="auth.database=c4-order-database" \
    --namespace database"

run "helm install mongo-notify bitnami/mongodb \
    --set="auth.rootPassword=root-password" \
    --set="auth.username=admin" \
    --set="auth.password=admin" \
    --set="auth.database=c4-notify-database" \
    --namespace database"

run "helm install mongo-payment bitnami/mongodb \
    --set="auth.rootPassword=root-password" \
    --set="auth.username=admin" \
    --set="auth.password=admin" \
    --set="auth.database=c4-payment-database" \
    --namespace database"

run "helm install postgres bitnami/postgresql \
    --set postgresqlPassword=pgpassword,postgresqlDatabase=c4-customer-database \
    --namespace database"

run "helm install my-kafka incubator/kafka \
    --namespace message"

run "helm install keycloak codecentric/keycloak \
    --namespace iam"