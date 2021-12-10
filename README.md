
## Panopticon

> **Warning**: This is a demo or PoC project,
  will not consider any security issue.

* A simplified K8s native ML platform that
  integrates the below components.
  - [MLflow](https://github.com/mlflow/mlflow)
  - [Kubeflow Pipelines](https://github.com/kubeflow/pipelines)
  - [Kubeflow Training Operator](https://github.com/kubeflow/training-operator)
  - [Dapr](https://github.com/dapr/dapr)
  - [GraphScope](https://github.com/alibaba/GraphScope)
* We use [Argo CD](https://github.com/argoproj/argo-cd) to maintain the cluster.
* Tested Kubernetes: `v1.21`

### Install Argo CD

```zsh
k apply -k argocd
```

* To access the Argo CD UI

```zsh
k port-forward svc/argocd-server \
  -n argocd 8080:443

# Username: admin
# Get password
k get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
```

### Install Panopticon

```zsh
k apply -f panopticon.yaml
# The output should be:
# $ application.argoproj.io/panopticon created
```

```zsh
# This action requires the service "sealed-secrets-controller"
pip install bcrypt passlib
./setup_credentials.sh
```

* If you only want to deploy single application

```zsh
k apply -f argocd-applications/dapr.yaml
```

### Access the dashboard

```zsh
k port-forward svc/istio-ingressgateway \
  -n istio-system 8888:443
```

## Notes

### GraphScope

* ReplicaSet: `gs-engine-graphscope`
* Pod: `graphscope-coordinator`
  - Containers: `coordinator-container`, `jupyter`
* Pod: `gs-engine-graphscope`
  - Containers: `engine`, `vineyard`

### GraphScope Store

* StatefulSet
  - `graphscope-store-coordinator`
* StatefulSet
  - `graphscope-store-frontend`
* StatefulSet
  - `graphscope-store-ingestor`
* StatefulSet
  - `graphscope-store-store`
