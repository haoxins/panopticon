
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
