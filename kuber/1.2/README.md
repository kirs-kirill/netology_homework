# Домашнее задание к занятию «Базовые объекты K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера. 

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов.
2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/).

------

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

#### Ответ

1. [hello-world-pod.yaml](./hello-world-pod.yaml)
2. 
``` yaml
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
```
3. 
``` shell
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl apply -f ./hello-world-pod.yaml 
pod/hello-world created
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl get pods
NAME          READY   STATUS    RESTARTS   AGE
hello-world   1/1     Running   0          9s
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl port-forward pods/hello-world 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

``` shell
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ curl 127.0.0.1:8080


Hostname: hello-world

Pod Information:
        -no pod information available-

Server values:
        server_version=nginx: 1.12.2 - lua: 10010

Request Information:
        client_address=127.0.0.1
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://127.0.0.1:8080/

Request Headers:
        accept=*/*  
        host=127.0.0.1:8080  
        user-agent=curl/8.5.0  

Request Body:
        -no body in request-
```
------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

#### Ответ
1. [netology-web-pod.yaml](./netology-web-pod.yaml)
2. 
``` yaml
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2

```
3. [service.yaml](./service.yaml)
4. 
``` shell
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl apply -f ./netology-web-pod.yaml 
pod/netology-web created
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl apply -f ./service.yaml 
service/netology-svc created
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl get pod
NAME           READY   STATUS    RESTARTS   AGE
netology-web   1/1     Running   0          17s        
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl get service
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
kubernetes     ClusterIP   10.152.183.1    <none>        443/TCP    20h
netology-svc   ClusterIP   10.152.183.86   <none>        8080/TCP   17s


@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ kubectl port-forward services/netology-svc 8080:8080 
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

``` shell
@usem-notebook:~/git_repo/netology_homework/kuber/1.2$ curl 127.0.0.1:8080


Hostname: netology-web

Pod Information:
        -no pod information available-

Server values:
        server_version=nginx: 1.12.2 - lua: 10010

Request Information:
        client_address=127.0.0.1
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://127.0.0.1:8080/

Request Headers:
        accept=*/*  
        host=127.0.0.1:8080  
        user-agent=curl/8.5.0  

Request Body:
        -no body in request-
```
------
