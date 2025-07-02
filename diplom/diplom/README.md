## Создание облачной инфраструктуры

1. [Создание сервисного аккаунта с правами записи, бакета и YDB](./sas3/)
2. [Подготовьте backend для Terraform](./sas3/)
3. [Создайте конфигурацию Terrafrom, используя созданный бакет ранее как бекенд для хранения стейт файла.](./backend/providers.tf)
    ```
    terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -reconfigure
    ```
4. [Создайте VPC с подсетями в разных зонах доступности.](./backend/vpc.tf)
      <detail>
          $ yc vpc network list
          +----------------------+----------------+
          |          ID          |      NAME      |
          +----------------------+----------------+
          | enpov1n3be2ep0cm93ke | diplom-network |
          +----------------------+----------------+
  
          $ yc vpc subnet list
          +----------------------+----------+----------------------+----------------+---------------+-------------------+
          |          ID          |   NAME   |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |       RANGE       |
          +----------------------+----------+----------------------+----------------+---------------+-------------------+
          | e2lupvcnjcamrfhkp525 | subnet_b | enpov1n3be2ep0cm93ke |                | ru-central1-b | [192.168.20.0/24] |
          | e9br8gqgfr9hepkt2aep | subnet_a | enpov1n3be2ep0cm93ke |                | ru-central1-a | [192.168.10.0/24] |
          | fl8qi7ee7qgfi7e7duhg | subnet_d | enpov1n3be2ep0cm93ke |                | ru-central1-d | [192.168.30.0/24] |
          +----------------------+----------+----------------------+----------------+---------------+-------------------+
      </detail>