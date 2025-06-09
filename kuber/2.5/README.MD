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

    В качестве приложения возьмём deployment'ы из задания 1.5.

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
        image: nginx
        tag: latest
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
    ➜  2.5 git:(main) ✗ helm install hw-app --set deployment.front.replicas=3 hw-chart
    NAME: hw-app
    LAST DEPLOYED: Mon Jun  9 11:31:32 2025
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    ➜  2.5 git:(main) ✗ helm list
    NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
    hw-app  default         1               2025-06-09 11:31:32.769568202 +0000 UTC deployed        hw-chart-0.1.0  1.16.0     
    ➜  2.5 git:(main) ✗ kubectl get all
    NAME                                     READY   STATUS    RESTARTS   AGE
    pod/hw-app-deployment-5dd85d97b8-2qkbm   1/1     Running   0          35s
    pod/hw-app-deployment-5dd85d97b8-8h7dq   1/1     Running   0          35s
    pod/hw-app-deployment-5dd85d97b8-cl9qp   1/1     Running   0          35s

    NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    service/hw-app-frontend   ClusterIP   10.109.86.104   <none>        9001/TCP   35s
    service/kubernetes        ClusterIP   10.96.0.1       <none>        443/TCP    12d

    NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/hw-app-deployment   3/3     3            3           35s

    NAME                                           DESIRED   CURRENT   READY   AGE
    replicaset.apps/hw-app-deployment-5dd85d97b8   3         3         3       35s
    ```

2. ``` sh
    helm install hw-app-v1 ./hw-chart --namespace app1
    helm install hw-app-v2 ./hw-chart --namespace app1
    helm install hw-app-v3 ./hw-chart --namespace app2
    ```

    ``` sh
    ➜  2.5 git:(main) ✗ helm install hw-app-v1 ./hw-chart --namespace app1
    NAME: hw-app-v1
    LAST DEPLOYED: Mon Jun  9 11:29:51 2025
    NAMESPACE: app1
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    ➜  2.5 git:(main) ✗ helm install hw-app-v2 ./hw-chart --namespace app1
    NAME: hw-app-v2
    LAST DEPLOYED: Mon Jun  9 11:29:55 2025
    NAMESPACE: app1
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    ➜  2.5 git:(main) ✗ helm install hw-app-v3 ./hw-chart --namespace app2
    NAME: hw-app-v3
    LAST DEPLOYED: Mon Jun  9 11:29:58 2025
    NAMESPACE: app2
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    ➜  2.5 git:(main) ✗ helm list -A
    NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
    hw-app-v1       app1            1               2025-06-09 11:29:51.053467859 +0000 UTC deployed        hw-chart-0.1.0  1.16.0     
    hw-app-v2       app1            1               2025-06-09 11:29:55.30700384 +0000 UTC  deployed        hw-chart-0.1.0  1.16.0     
    hw-app-v3       app2            1               2025-06-09 11:29:58.915411829 +0000 UTC deployed        hw-chart-0.1.0  1.16.0 
    ```
