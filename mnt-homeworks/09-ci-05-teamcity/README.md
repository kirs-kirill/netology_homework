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

5. Для deploy будет необходимо загрузить `settings.xml` в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.

6. В `pom.xml` необходимо поменять ссылки на репозиторий и nexus.
7. <details>
    <summary>Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.</summary>

    По ветке мастер сборка прошла успешно и артефакты нормально загрузились в нексус.
    ![complete](./images/5.png)

    ![nexus](./images/6.png)

    </details>

8. <details>
    <summary>Мигрируйте <code>build configuration</code> в репозиторий.</summary>

    По ветке мастер сборка прошла успешно и артефакты нормально загрузились в нексус.
    ![version_settings](./images/7.png)

    ![commit](./images/8.png)

    </details>

9. <details>
    <summary>Создайте отдельную ветку <code>feature/add_reply</code> в репозитории.</summary>

    ![feature/add_reply](./images/9.png)

    </details>

10. <details>
    <summary>Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово <code>hunter</code>.</summary>

    ![huter_gonna_hunt](./images/10.png)

    </details>

11. <details>
    <summary>Дополните тест для нового метода на поиск слова <code>hunter</code> в новой реплике.</summary>

    ![huter_gonna_hunt](./images/11.png)

    </details>

12. <details>
    <summary>Сделайте push всех изменений в новую ветку репозитория.</summary>

    ![push](./images/12.png)

    </details>

13. <details>
    <summary>Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.</summary>

    ![autorun](./images/13.png)

    </details>

14. <details>
    <summary>Внесите изменения из произвольной ветки <code>feature/add_reply</code> в <code>master</code> через <code>Merge</code>.</summary>

    ![merge](./images/14.png)

    </details>

15. <details>
    <summary>Убедитесь, что нет собранного артефакта в сборке по ветке <code>master</code>.</summary>

    ![no_artifacts](./images/15.png)

    </details>

16. <details>
    <summary>Настройте конфигурацию так, чтобы она собирала <code>.jar</code> в артефакты сборки.</summary>

    ![jar_artifacts](./images/16.png)

    </details>

17. <details>
    <summary>Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.</summary>

    ![artifacts](./images/17.png)

    </details>

18. <details>
    <summary>Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.</summary>

    ![save_settings](./images/18.png)

    </details>
