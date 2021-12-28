
## Panopticon

> **Warning**: This is a demo or PoC project,
  **will not consider any security issue**.

* A simplified K8s native ML platform that
  integrates the below components.
  - [Kubeflow Pipelines](https://github.com/kubeflow/pipelines)
  - [Kubeflow Training Operator](https://github.com/kubeflow/training-operator)
  - [GraphScope](https://github.com/alibaba/GraphScope)
  - [Dapr](https://github.com/dapr/dapr)
* We use [Argo CD](https://github.com/argoproj/argo-cd) to maintain the cluster.

* Kubernetes: `v1.22+`

### Install Argo CD

```zsh
k apply -k argocd
```

### Install Panopticon

* Change the IP placeholder `localhost` with your cluster IP

```zsh
k apply -f panopticon.yaml
# The output should be:
# $ application.argoproj.io/panopticon created
```

* If you only want to deploy single application

```zsh
k apply -f argocd-applications/dapr.yaml
```

### Access the Argo CD UI

```zsh
k port-forward svc/argocd-server \
  -n argocd 8080:443
# Username: admin
# Get password
k get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
```

### Access the dashboard

* Username: `test@demo.me`
* Password: `test`

## Notes
