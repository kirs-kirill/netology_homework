# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Цель задания

В тестовой среде Kubernetes нужно создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs). 
2. [Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/). 
3. [Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/). 
4. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

#### Решение

0. В minicube перед созданием PV с локальным содержимым нужно сначала примонтировать локальный каталог внутри minikube:
    ```
    minikube mount /path/from/system:/path/into/minikube
    ```
    У меня это:
    ```
    minikube mount ./hw:/tmp/hw
    ```
    Было бы здорово, если бы об этом сообщили на вебинаре или оставили заметку в задании и мне не пришлось бы 2 дня тестировать разные версии minikube и mikrok8s на разных системах, думая что я что-то делаю неправильно.
1. [`deployment.yaml`](./deployment.yaml)
2. [`pv.yaml`](./pv.yaml), [`pvc.yaml`](./pvc.yaml)
3. ``` sh
    ➜  2.2 git:(main) ✗ kubectl apply -f pv.yaml -f pvc.yaml -f deployment.yaml
    persistentvolume/pv-homework created
    persistentvolumeclaim/pvc-storage created
    deployment.apps/2-2-deployment created

    ➜  2.2 git:(main) ✗ kubectl get pv && kubectl get pvc
    NAME          CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
    pv-homework   1Gi        RWO            Retain           Bound    default/pvc-storage   manual         <unset>                          3s
    NAME          STATUS   VOLUME        CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
    pvc-storage   Bound    pv-homework   1Gi        RWO            manual         <unset>                 3s

    ➜  2.2 git:(main) ✗ kubectl get pods
    NAME                             READY   STATUS    RESTARTS   AGE
    2-2-deployment-878b99f75-68cr8   2/2     Running   0          9s

    ➜  2.2 git:(main) ✗ kubectl exec 2-2-deployment-878b99f75-68cr8 -c busybox -- cat /tmp/hwstorage/log.txt 
    2025-05-30 09:37:25 Test from busybox
    2025-05-30 09:37:30 Test from busybox
    2025-05-30 09:37:35 Test from busybox
    2025-05-30 09:37:40 Test from busybox

    ➜  2.2 git:(main) ✗ kubectl exec 2-2-deployment-878b99f75-68cr8 -c multitool -- cat /tmp/hwstorage/log.txt 
    2025-05-30 09:37:25 Test from busybox
    2025-05-30 09:37:30 Test from busybox
    2025-05-30 09:37:35 Test from busybox
    2025-05-30 09:37:40 Test from busybox
    ```
4. ``` sh
    ➜  2.2 git:(main) ✗ kubectl delete -f pvc.yaml -f deployment.yaml
    persistentvolumeclaim "pvc-storage" deleted
    deployment.apps "2-2-deployment" deleted

    ➜  2.2 git:(main) ✗ kubectl get pv
    NAME          CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                 STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
    pv-homework   1Gi        RWO            Retain           Released   default/pvc-storage   manual         <unset>                          57s
    ```
    PV перешел в статус `Released`, т.к. больше нет PVC, которое бы ассоциировалось с этим PV
5. ``` sh
    ➜  2.2 git:(main) ✗ ls ./hw
    log.txt
    ➜  2.2 git:(main) ✗ kubectl delete persistentvolume pv-homework 
    persistentvolume "pv-homework" deleted
    ➜  2.2 git:(main) ✗ ls ./hw                                    
    log.txt
    ```
    После удаления PV файл остался существовать, т.к. при создании PV было указано `persistentVolumeReclaimPolicy: Retain`

------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------


