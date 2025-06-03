# Домашнее задание к занятию «Конфигурация приложений»

### Цель задания

В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8s).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым GitHub-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/configuration/secret/) Secret.
2. [Описание](https://kubernetes.io/docs/concepts/configuration/configmap/) ConfigMap.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


#### Решение

1. [`deployment.yaml`](./exercise_1/deployment.yaml)
2. [`configMap.yaml`](./exercise_1/configMap.yaml)
    ``` yaml
          - name: multitool
            image: wbitt/network-multitool
            env:
            - name: HTTP_PORT
              valueFrom:
              configMapKeyRef:  # передаем env  из configMap
                name: my-app-cm
                key: HTTP_PORT
    ```
3. ``` sh
    ➜  exercise_1 git:(main) ✗ kubectl get pods
    NAME                      READY   STATUS    RESTARTS   AGE
    my-app-65cff77bfb-htnp8   2/2     Running   0          24m
    ```
4. [`service.yaml`](./exercise_1/service.yaml)
    ``` sh
    ➜  exercise_1 git:(main) ✗ kubectl exec my-app-65cff77bfb-htnp8 -c multitool -ti -- bash     
    my-app-65cff77bfb-htnp8:/# nslookup my-app-service
    Server:         10.96.0.10
    Address:        10.96.0.10#53

    Name:   my-app-service.default.svc.cluster.local
    Address: 10.106.198.13

    my-app-65cff77bfb-htnp8:/# curl my-app-service.default.svc.cluster.local
    <html>
    <body>
    Kirsanov test page
    </body>
    </html>
    ```

------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

#### Решение

1. [`deployment.yaml`](./exercise_2/deployment.yaml)
2. [`configMap.yaml`](./exercise_2/configMap.yaml)
    ``` yaml
    spec:
      volumes:
      - name: cm-volume   
        configMap:  # подключаем configMap как volume
          name: my-app-cm # имя configMap
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts: # монтируем volume с configMap
        - name: cm-volume
          mountPath: /usr/share/nginx/html
    ```
3. [`secret.yaml`](./exercise_2/secret.yaml)
4. [`ingress.yaml`](./exercise_2/ingress.yaml), [`service.yaml`](./exercise_2/service.yaml)

    ``` sh
    ➜  exercise_2 git:(main) ✗ curl https://k8s.test
    curl: (60) SSL certificate problem: self-signed certificate
    More details here: https://curl.se/docs/sslcerts.html

    curl failed to verify the legitimacy of the server and therefore could not
    establish a secure connection to it. To learn more about this situation and
    how to fix it, please visit the web page mentioned above.
    ```

    Как видим, curl ругается на непроверенный сертификат, попробуем проигнорировать ошибку:

    ``` sh
    ➜  exercise_2 git:(main) curl https://k8s.test --insecure
    <html>
    <body>
    Kirsanov second test page
    </body>
    </html>
    ```
------
