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

run "microk8s.helm install stable/mongodb \
    --name="mongo-order" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-order-database" \
    --namespace database"

run "microk8s.helm install stable/mongodb \
    --name="mongo-notify" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-notify-database" \
    --namespace database"

run "microk8s.helm install stable/mongodb \
    --name="mongo-payment" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-payment-database" \
    --namespace database"

run "microk8s.helm install stable/rabbitmq \
    --name rabbitmq \
    --set="rabbitmq.username=guest" \
    --set="rabbitmq.password=guest" \
    --set="persistence.size=1Gi" \
    --namespace message"

run "microk8s.helm install stable/postgresql \
    --name postgres \
    --set postgresqlPassword=pgpassword,postgresqlDatabase=c4-customer-database \
    --namespace database"