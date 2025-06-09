# Домашнее задание к занятию «Helm»

### Цель задания

В тестовой среде Kubernetes необходимо установить и обновить приложения с помощью Helm.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение, например, MicroK8S.
2. Установленный локальный kubectl.
3. Установленный локальный Helm.
4. Редактор YAML-файлов с подключенным репозиторием GitHub.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://helm.sh/docs/intro/install/) по установке Helm. [Helm completion](https://helm.sh/docs/helm/helm_completion/).

------

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

#### Решение

1. Создаем  helm-чарт и удаляем лишнее .

    ``` sh
    ➜  2.5 git:(main) ✗ helm create hw-chart        
    Creating hw-chart
    ➜  2.5 git:(main) ✗ cd ./hw-chart 
    ➜  hw-chart git:(main) ✗ rm -rf ./templates/*
    ```

    В качестве приложения возьмём deployment'ы и ingress из задания 1.5. А в качестве образа для frontend'а образ из задания по докеру, не зря же делали.

    В результате имеем следующие файлы:
    ``` sh
    ➜  2.5 git:(main) ✗ tree
    .
    ├── [hw-chart](./hw-chart/)
    │   ├── Chart.yaml
    │   ├── templates
    │   │   ├── back-service.yaml
    │   │   ├── back.yaml
    │   │   ├── front-service.yaml
    │   │   ├── front.yaml
    │   │   └── ingress.yaml
    │   └── values.yaml
    └── README.MD
    ```

    Пример [`Chart.yaml`](./hw-chart/Chart.yaml):
    ```yaml
    apiVersion: v2
    name: hw-chart
    description: Chart for kuber-2.5
    type: application
    version: 0.1.0
    appVersion: "1.16.0"
    ```

    Содержимое [`values.yaml`](./hw-chart/values.yaml):
    ``` yaml
    deployment:
      front:
        name: frontend
        replicas: 1
        image: kirskirill/custom-nginx
        tag: 1.0.0
        containerPort: 80
        labels:
          app: frontend
      back:
        name: backend
        replicas: 1
        image: wbitt/network-multitool
        tag: latest
        containerPort: 80
        labels:
          app: backend

    service:
      front:
        name: frontend-service
        selector: frontend
        ports:
          port: 9001
          targetPort: 80
      back:
        name: backend-service
        selector: backend
        ports:
          port: 9002
          targetPort: 80

    ingress:
      name: ingress
      host: k8s.test
    ```

    Пример [`front.yaml`](./hw-chart/templates/front.yaml)
    ``` yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: {{ .Values.deployment.front.name }}
      labels:
        app: {{ .Values.deployment.front.labels.app }}
    spec:
      replicas: {{ .Values.deployment.front.replicas }}
      selector:
        matchLabels:
          app: {{ .Values.deployment.front.labels.app }}
      template:
        metadata:
          labels: 
            app: {{ .Values.deployment.front.labels.app }}
        spec:
          containers:
          - name: {{ .Values.deployment.front.name }}
            image: {{ .Values.deployment.front.image }}:{{ .Values.deployment.front.tag }}
            ports: 
            - containerPort: {{ .Values.deployment.front.containerPort }}
    ```
------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

#### Решение

0. Создаем нужные namespace:

        kubectl create namespace app1
        kubectl create namespace app2

1. Проверим что чарт запускается: 
    ``` sh
    ➜  2.5 git:(main) ✗ helm install hw-app --set deployment.front.replicas=10 --set deployment.back.replicas=10 hw-chart

    NAME: hw-app
    LAST DEPLOYED: Mon Jun  9 06:52:25 2025
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    ➜  2.5 git:(main) ✗ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/backend-6f4f7644f7-2qnsz    1/1     Running   0          59s
    pod/backend-6f4f7644f7-4rmv8    1/1     Running   0          58s
    pod/backend-6f4f7644f7-5cb46    1/1     Running   0          59s
    pod/backend-6f4f7644f7-8mfrf    1/1     Running   0          59s
    pod/backend-6f4f7644f7-fbmnv    1/1     Running   0          59s
    pod/backend-6f4f7644f7-gh77k    1/1     Running   0          58s
    pod/backend-6f4f7644f7-lxrnp    1/1     Running   0          59s
    pod/backend-6f4f7644f7-nzr5p    1/1     Running   0          59s
    pod/backend-6f4f7644f7-wvc24    1/1     Running   0          58s
    pod/backend-6f4f7644f7-zlf6p    1/1     Running   0          59s
    pod/frontend-5f998bfcb8-9pq4k   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-bzx7v   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-fplnb   1/1     Running   0          58s
    pod/frontend-5f998bfcb8-gkqpm   1/1     Running   0          58s
    pod/frontend-5f998bfcb8-gwhq5   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-j5lnk   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-k524f   1/1     Running   0          58s
    pod/frontend-5f998bfcb8-mfgx4   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-mswl2   1/1     Running   0          59s
    pod/frontend-5f998bfcb8-qwd6r   1/1     Running   0          59s

    NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    service/backend-service    ClusterIP   10.110.70.173    <none>        9002/TCP   59s
    service/frontend-service   ClusterIP   10.109.121.236   <none>        9001/TCP   59s
    service/kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP    11d

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/backend    10/10   10           10          59s
    deployment.apps/frontend   10/10   10           10          59s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/backend-6f4f7644f7    10        10        10      59s
    replicaset.apps/frontend-5f998bfcb8   10        10        10      59s
    ➜  2.5 git:(main) ✗ curl k8s.test
    <html>
    <head>
    Hey, Netology
    </head>
    <body>
    <h1>I will be DevOps Engineer!</h1>
    </body>
    </html>   
    ```

2. ``` sh
    helm install hw-app-v1 -n app1 hw-chart
    helm install hw-app-v2 -n app1 hw-chart
    helm install hw-app-v3 -n app2 hw-chart
    ```
