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

run "kustomize build c4-customer/overlays/development/ | microk8s.kubectl -n c4 apply -f -"

run "kustomize build c4-order/overlays/development/ | microk8s.kubectl -n c4 apply -f -"

run "kustomize build c4-payment/overlays/development/ | microk8s.kubectl -n c4 apply -f -"

run "kustomize build c4-ecommerce/overlays/development/ | microk8s.kubectl -n c4 apply -f -"

run "kustomize build c4-notify/overlays/development/ | microk8s.kubectl -n c4 apply -f -"

run "kustomize build c4-type/overlays/development/ | microk8s.kubectl -n c4 apply -f -"