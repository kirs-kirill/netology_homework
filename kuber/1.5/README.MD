# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить доступ к двум приложениям снаружи кластера по разным путям.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым Git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S.
2. [Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Service.
3. [Описание](https://kubernetes.io/docs/concepts/services-networking/ingress/) Ingress.
4. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.


#### Решение. 

1. [`back.yaml`](./back.yaml)
2. [`front.yaml`](./front.yaml)
3. [`front-service.yaml`](./front-service.yaml), [`back-service.yaml`](./back-service.yaml)
4. 
    ``` sh
    usem@mbp ~ % kubectl exec backend-9b4d8c545-xtdzd -ti -- bash
    backend-9b4d8c545-xtdzd:/# nslookup frontend-service
    Server:		10.96.0.10
    Address:	10.96.0.10#53

    Name:	frontend-service.default.svc.cluster.local
    Address: 10.107.191.153

    backend-9b4d8c545-xtdzd:/# curl frontend-service.default.svc.cluster.local:9001
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif; }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and working. Further configuration is required.</p>

    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>

    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>
    ```
5.  
    ``` sh
    usem@mbp 1.5 % kubectl get pods
    NAME                        READY   STATUS    RESTARTS   AGE
    backend-9b4d8c545-xtdzd     1/1     Running   0          20m
    frontend-558cdbfb74-92kcg   1/1     Running   0          20m
    frontend-558cdbfb74-9mkbk   1/1     Running   0          20m
    frontend-558cdbfb74-qffjq   1/1     Running   0          20m
    usem@mbp 1.5 % kubectl get services
    NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    backend-service    ClusterIP   10.97.214.47     <none>        9002/TCP   111s
    frontend-service   ClusterIP   10.107.191.153   <none>        9001/TCP   111s
    kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP    3d23h
    ```

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

#### Решение

1. ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.5$ microk8s enable ingress
    Infer repository core for addon ingress
    Enabling Ingress
    ingressclass.networking.k8s.io/public created
    ingressclass.networking.k8s.io/nginx created
    namespace/ingress created
    serviceaccount/nginx-ingress-microk8s-serviceaccount created
    clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
    role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
    clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
    rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
    configmap/nginx-load-balancer-microk8s-conf created
    configmap/nginx-ingress-tcp-microk8s-conf created
    configmap/nginx-ingress-udp-microk8s-conf created
    daemonset.apps/nginx-ingress-microk8s-controller created
    Ingress is enabled
    ```
2. [`ingress.yaml`](./ingress.yaml)
3. ![`result`](./images/1.png)
------