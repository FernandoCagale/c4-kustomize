# c4-kustomize

[kustomize](https://kustomize.io/) `Kubernetes native configuration management`

## Flow

![alt tag](img/eda.png)

Create all **namespaces**


```sh
$   kubectl apply -k c4/base
```

![](img/c4.gif)


## Helm

Helm install **mongo-order**

```sh
$   microk8s.helm install stable/mongodb \
    --name="mongo-order" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-order-database" \
    --namespace database
```

Helm install **mongo-notify**

```sh
$   microk8s.helm install stable/mongodb \
    --name="mongo-notify" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-notify-database" \
    --namespace database
```

Helm install **mongo-payment**

```sh
$   microk8s.helm install stable/mongodb \
    --name="mongo-payment" \
    --set="mongodbRootPassword=root-password" \
    --set="mongodbUsername=admin" \
    --set="mongodbPassword=admin" \
    --set="mongodbDatabase=c4-payment-database" \
    --namespace database
```

Helm install **rabbitmq**

```sh
$   microk8s.helm install stable/rabbitmq \
    --name rabbitmq \
    --set="rabbitmq.username=guest" \
    --set="rabbitmq.password=guest" \
    --set="persistence.size=1Gi" \
    --namespace message
```

Helm install **postgres**

```sh
$   microk8s.helm install stable/postgresql \
    --name postgres \
    --set postgresqlPassword=pgpassword,postgresqlDatabase=c4-customer-database \
    --namespace database
```

## kustomize 

Install [c4-customer](https://github.com/FernandoCagale/c4-customer)

```sh
$   kustomize build c4-customer/overlays/development/ | microk8s.kubectl -n c4 apply -f -
```

Install [c4-order](https://github.com/FernandoCagale/c4-order)

```sh
$   kustomize build c4-order/overlays/development/ | microk8s.kubectl -n c4 apply -f -
```

Install [c4-payment](https://github.com/FernandoCagale/c4-payment)

```sh
$   kustomize build c4-payment/overlays/development/ | microk8s.kubectl -n c4 apply -f -
```

Install [c4-ecommerce](https://github.com/FernandoCagale/c4-ecommerce)

```sh
$   kustomize build c4-ecommerce/overlays/development/ | microk8s.kubectl -n c4 apply -f -
```

Install [c4-notify](https://github.com/FernandoCagale/c4-notify)

```sh
$   kustomize build c4-notify/overlays/development/ | microk8s.kubectl -n c4 apply -f -
```