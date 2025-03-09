# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.


#### Ответ

1. [`deployment.yaml`](./deployment.yaml). Во избежание конфликтов портов с `nginx`, используем образ `multitool` с тегом `openshift`, там ипользуются порты `1180` и `11443`.
2. `deployment.yaml`:
    ``` yaml
    spec:
      replicas: 2
    ```

3. Поды с 1 репликой:
    ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ kubectl get pods
    NAME                      READY   STATUS    RESTARTS   AGE
    my-app-64bc7c7dcf-zgcdz   2/2     Running   0          46m
    ```

    Поды с 2 репликами:
    ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ kubectl get pods
    NAME                      READY   STATUS    RESTARTS   AGE
    my-app-64bc7c7dcf-9lwdj   2/2     Running   0          29s
    my-app-64bc7c7dcf-zgcdz   2/2     Running   0          47m
    ```

    Если обратно указать в yaml-файле 1 реплику, то удалится самая свежая.


4. [`service.yaml`](./service.yaml)
    ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ kubectl get service
    NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)              AGE
    kubernetes       ClusterIP   10.152.183.1     <none>        443/TCP              2d3h
    my-app-service   ClusterIP   10.152.183.146   <none>        11443/TCP,1180/TCP   3m18s

    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ curl 10.152.183.146:1180
    WBITT Network MultiTool (with NGINX) - my-app-64bc7c7dcf-zgcdz - 10.1.148.166 - HTTP: 1180 - HTTPS: 11443 . (Formerly praqma/network-multitool)
    ```

5. [`pod.yaml`](./pod.yaml)
    ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ kubectl get pods
    NAME                      READY   STATUS    RESTARTS   AGE
    my-app-64bc7c7dcf-9lwdj   2/2     Running   0          127m
    my-app-64bc7c7dcf-zgcdz   2/2     Running   0          174m
    my-app-pod                1/1     Running   0          14s
    ```

    `curl`

    ``` sh
    @usem-notebook:~/git_repo/netology_homework/kuber/1.3$ kubectl exec my-app-pod -c multitool -- curl http://my-app-service:1180
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
    100   144  100   144    0     0  46738      0 --:--:-- --:--:-- --:--:-- 72000
    WBITT Network MultiTool (with NGINX) - my-app-64bc7c7dcf-zgcdz - 10.1.148.166 - HTTP: 1180 - HTTPS: 11443 . (Formerly praqma/network-multitool)
    ```

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

#### Ответ


------
