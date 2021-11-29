
## Panopticon

> **Warning**: This is a demo or PoC project,
  will not consider any security issue.

* A simplified K8s native ML platform that
  integrates the below components.
  - [Kubeflow Pipelines](https://github.com/kubeflow/pipelines)
  - [Kubeflow Training Operator](https://github.com/kubeflow/training-operator)
  - [Dapr](https://github.com/dapr/dapr)
  - [GraphScope](https://github.com/alibaba/GraphScope)
* We use [Argo CD](https://github.com/argoproj/argo-cd) to maintain the cluster.

### Install Argo CD

```zsh
k apply -k argocd
```

### Install Panopticon

```zsh
k apply -f panopticon.yaml
# The output should be:
# $ application.argoproj.io/panopticon created
```
