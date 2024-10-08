# Задача 1

Полная (аппаратная) виртуализация как следует из названия полностью эмулирует физический компьютер с соответствующими физическими устройствами обеспечивая тотальную изоляцию гостевой ОС

При паравиртуализации используются гостевые операционные системы оптимизированные для работы с гипервизором, что позволяет увеличить эффективность утилизации аппаратных ресурсов. В отличие от полной виртуализации в данной технологии допускается прямое использование гостевой ОС аппаратных ресурсов хоста

Виртуализация на уровне ОС реализуется без отдельного слоя гипервизора, виртуализируется пользовательское окружение ОС.

# Задача 2

Выберите один из вариантов платформы в зависимости от задачи. Здесь нет однозначно верного ответа так как все зависит от конкретных условий: финансирование, компетенции специалистов, удобство использования, надежность, требования ИБ и законодательства, фазы луны.

Тип платформы:

- физические сервера;
- паравиртуализация;
- виртуализация уровня ОС;

Задачи:

- высоконагруженная база данных MySql, критичная к отказу;
- различные web-приложения;
- Windows-системы для использования бухгалтерским отделом;
- системы, выполняющие высокопроизводительные расчёты на GPU.

Объясните критерии выбора платформы в каждом случае.

## Ответ

TL;DR: Как и указано в задании, требования и возможности при выполнении задач могут быть разные.

 ||физические сервера|паравиртуализация|виртуализация уровня ОС|
 |:-|:-:|:-:|:-:|
 |высоконагруженная база данных MySql, критичная к отказу|:heavy_check_mark:
 |различные web-приложения|||:heavy_check_mark:
 |Windows-системы для использования бухгалтерским отделом|:heavy_check_mark:|:heavy_check_mark:
 |системы, выполняющие высокопроизводительные расчёты на GPU|:heavy_check_mark:

1. Для баз данных MySql, критичных к отказу, стоит использовать физические сервера, из-за более высокой, в сравнении с вируализацией, эффективностью использования мощностей и меньшего количества точек отказа.
2. Для различных web-приложений достаточно использовать виртуализацию уровня ОС, из-за легковесности образов и меньшего потребения ресурсов, в сравнении с остальными вариантами.
3. Насчет Windows-системы для использования бухгалтерским отделом сложно выбрать, но думаю, будет правильней выбрать обычные ПК или паравиртуализацию с доступом по RDP. Это связано с возможной специфичностью бухгалтерского ПО и компетенциями бухгалтеров при работе с ОС.
4. Для расчетов на GPU стоит использовать фиизческие сервера за счет более Высокой эффективность утилизации вычислительных мощностей.

# Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

## Ответ

1. **Hyper-V** - как и указано в лекции, является defacto стандартным выбором для Windows based-инфраструктуры.
2. Могут подойти Xen, KVM или Proxmox VE в зависимости от выполняемых операций, т.к. исходя из бенчмарков их производительность сильно зависит от выполняемых задач.
3. Microsoft Hyper-V Server имеющий наибольшую совместимость с Windows системами или как альтернатива Xen
4. Наибольшую скорость развёртывания в данном случае могут обеспечить решения виртуализации уровне ОС по типу Docker


# Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет?

## Ответ

Проблемы:

1. Увеличиваются требования к персоналу в части навыков эксплуатации разнородного ПО виртуализации

2. Увеличиваются операционные расходы в случае использования нескольких проприетарных систем управления виртуализацией

3. Усложняются операции по переносу виртуальных машин между различными средами и масштабированию

Необходимость создания гетерогенной среды может продиктовываться решаемыми задачами:

- необходимость распределения аппаратных ресурсов посредством полной виртуализации и облегчения задач размещения и развёртывания программного обеспечения посредством виртуализационных решений на уровне ОС;
