# Домашнее задание к занятию 11 «Teamcity»

1. <details>
    <summary>Создайте новый проект в teamcity на основе fork</summary>

    ![1st_project](./images/1.png)

    </details>
2. <details>
    <summary>Сделайте autodetect конфигурации.</summary>

    ![autodetect](./images/2.png)

    </details>
3. <details>
    <summary>Сохраните необходимые шаги, запустите первую сборку master.</summary>

    Сборка выполнена успешно.

    ![run_master](./images/3.png)

    </details>
4. <details>
    <summary>Поменяйте условия сборки: если сборка по ветке <code>master</code>, то должен происходит <code>mvn clean deploy</code>, иначе <code>mvn clean test</code>.</summary>

    ![branches](./images/4.png)

    </details>

5. [x] Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
6. [x] В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. <details>
    <summary>Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.</summary>
    
    По ветке мастер сборка прошла успешно и артефакты нормально загрузились в нексус.
    ![complete](./images/5.png)
    
    ![nexus](./images/6.png)
    
    </details>

