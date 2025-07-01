## Создание облачной инфраструктуры

1. [Создание сервисного аккаунта с правами записи, бакета и YDB](./sas3/)
2. [Подготовьте backend для Terraform]

`terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -reconfigure`