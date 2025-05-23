# Домашнее задание к занятию «Хранение в K8s. Часть 1»

### Цель задания

В тестовой среде Kubernetes нужно обеспечить обмен файлами между контейнерам пода и доступ к логам ноды.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке MicroK8S](https://microk8s.io/docs/getting-started).
2. [Описание Volumes](https://kubernetes.io/docs/concepts/storage/volumes/).
3. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.


#### Решение

[`deployment.yaml`](./deployment.yaml)

``` sh
usem@usem-notebook:~/git_repo/netology_homework/kuber/2.1$ kubectl apply -f deployment.yaml 
deployment.apps/busybox-multitool-deployment created
usem@usem-notebook:~/git_repo/netology_homework/kuber/2.1$ kubectl exec deployments/busybox-multitool-deployment -c multitool -- cat /shared-volume/log.txt
2025-05-23 05:03:44 Test from busybox
2025-05-23 05:03:49 Test from busybox
2025-05-23 05:03:54 Test from busybox
2025-05-23 05:03:59 Test from busybox
2025-05-23 05:04:04 Test from busybox
2025-05-23 05:04:09 Test from busybox
usem@usem-notebook:~/git_repo/netology_homework/kuber/2.1$
```

------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.


#### Решение

[`daemon-set.yaml`](./ds.yaml)

``` sh
usem@usem-notebook:~/.../2.1$ kubectl apply -f ds.yaml
daemonset.apps/multitool-daemonset created

usem@usem-notebook:~/.../2.1$ kubectl get ds
NAME                  DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
multitool-daemonset   1         1         1       1            1           <none>          5s

usem@usem-notebook:~/.../2.1$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
multitool-daemonset-j24j6   1/1     Running   0          10s

usem@usem-notebook:~/.../2.1$ kubectl exec pods/multitool-daemonset-j24j6 -- head -n5 /var/log/syslog
2025-04-19T16:50:17.809529+05:00 usem-notebook systemd[1]: rsyslog.service: Sent signal SIGHUP to main process 1311 (rsyslogd) on client request.
2025-04-19T16:50:17.809871+05:00 usem-notebook rsyslogd: [origin software="rsyslogd" swVersion="8.2312.0" x-pid="1311" x-info="https://www.rsyslog.com"] rsyslogd was HUPed
2025-04-19T16:50:17.813166+05:00 usem-notebook systemd[1]: logrotate.service: Deactivated successfully.
2025-04-19T16:50:17.813359+05:00 usem-notebook systemd[1]: Finished logrotate.service - Rotate log files.
2025-04-19T16:50:17.845602+05:00 usem-notebook microk8s.daemon-containerd[1611]: + return 1
```
