kubectl create serviceaccount hw-serviceaccount --namespace hw-namespace

kubectl describe serviceaccounts hw-serviceaccount --namespace hw-namespace

`sa-token.yaml`
``` yaml
apiVersion: v1
kind: Secret
metadata:
  name: hw-token
  namespace: hw-namespace
  annotations:
    kubernetes.io/service-account.name: hw-serviceaccount
type: kubernetes.io/service-account-token
```

kubectl describe secrets --namespace hw-namespace hw-token

kubectl describe serviceaccounts hw-serviceaccount --namespace hw-namespace

curl --header "Authorization: Bearer $TOKEN" https://10.128.0.6:16443 -k

----

Пользователь `homework`

openssl genrsa -out homework.key 2048
openssl req -new -key homework.key -out homework.csr -subj "/CN=homework/O=ops"

openssl x509 -req -in homework.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/certs/ca.key -CAcreateserial -out homework.crt -days 500

openssl x509 -req -in homework.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out homework.crt -days 500

kubectl config set-context netology --cluster=microk8s-cluster --user=homework

kubectl config use-context netology


microk8s enable rbac

`role.yaml`
``` yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: hw-role
  namespace: hw-namespace
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch", "create", "update", "delete"]
```

`RoleBinding.yaml`
``` yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: homework_role_binding
  namespace: hw-namespace
subjects:
- kind: User
  name: homework
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: hw-role
  apiGroup: rbac.authorization.k8s.io
```
