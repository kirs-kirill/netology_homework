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

1. [`deployment.yaml`](./deployment.yaml)
2. [`pv.yaml`](./pv.yaml), [`pvc.yaml`](./pvc.yaml)
3. ``` sh
    usem@usem-notebook:~/.../2.2$ kubectl apply -f pv.yaml -f pvc.yaml -f deployment.yaml 
    persistentvolume/pv-storage created
    persistentvolumeclaim/pvc-vol created
    deployment.apps/busybox-multitool-deployment created

    usem@usem-notebook:~/.../2.2$ kubectl get pv && kubectl get pvc && kubectl get pods
    NAME         CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
    pv-storage   1Gi        RWO            Retain           Bound    default/pvc-vol   manual         <unset>                          9m22s
    NAME      STATUS   VOLUME       CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
    pvc-vol   Bound    pv-storage   1Gi        RWO            manual         <unset>                 9m22s
    NAME                                            READY   STATUS    RESTARTS   AGE
    busybox-multitool-deployment-79594fb56c-7j48s   2/2     Running   0          28s

    usem@usem-notebook:~/.../2.2$ kubectl exec deployments/busybox-multitool-deployment -c multitool -- cat /shared-volume/log.txt
    2025-05-23 05:07:39 Test from busybox
    2025-05-23 05:07:44 Test from busybox
    2025-05-23 05:07:49 Test from busybox
    2025-05-23 05:07:54 Test from busybox
    ```
4. ``` sh
    usem@usem-notebook:~/.../2.2$ kubectl delete -f pv.yaml -f pvc.yaml
    persistentvolume "pv-storage" deleted
    persistentvolumeclaim "pvc-vol" deleted
    usem@usem-notebook:~/.../2.2$ kubectl get pv && kubectl get pvc
    No resources found
    No resources found in default namespace.
    ```
------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.