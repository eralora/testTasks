## Task 1 Bash script

- Скрипт должен по расписанию выбирать последний по дате изменения файл в директории
/tmp/test/files не старее 7 дней.
РЕШЕНИЕ: Использовал перемнные чтобы хранить данные последний по дате изменения файл. Использвал команду find чтобы выбрать файлы которые были изменены не позже 7 дней.

- Для выбранного файла записывать (добавлять в конец) в лог файл /tmp/test/script-log/sync.log
информацию о текущей дате, пути к файлу, его имени, и объему
РЕШЕНИЕ: Данные берем с переменных а чтобы записывать в конец необходимо использвать Redirection >>  а не >.

- Сжимать файл в отдельный архив .tar.gz с тем же именем, что и исходный файл и датой и временем
создания архива
РЕШЕНИЕ: Использовал tar чтобы архивировать файл и чтобы добавить время создания архива используем date 

- Перемещать архив в папку /tmp/test/archives
РЕШЕНИЕ: для перемещения использвал mv

- В случае успешного перемещения – удалять исходный файл из /tmp/test/files
РЕШЕНИЕ: Использовал условию if чтобы проверить была ли последняя команда завершена успешно ($? == 0) если да тогда удаляем файл rm

- Скрипт должен выполняться каждые 15 минут каждый день
РЕШЕНИЕ: Для решения в crontab -e добавил эту строку */15 * * * * /bin/bash /path/to/script/script.sh


Что сделать чтобы проверить работу ?
- Проверить что у вас существуют вот такие папки: /tmp/test/files, /tmp/test/archives, /tmp/test/script-log. Если нет то создать
- Если скрипт не запускается ввести эту команду "chmod +x path/to/your/script"
- Чтобы скрипт выполнялся каждые 15 минут каждый день, запустить "crontab -e"  и "*/15 * * * * /bin/bash <path/to/your/script>". Заменить path/to/your/script на путь к вашему скрипту.

## 4. Dockerfile

Для сборки приложения я использовал Multi-stage build. То есть я разделил создание образа по стадиям чтобы уменшить размер конечного образа. Подробнее я расписал в коментах в Dockerfile.

Что сделать чтобы проверить работу ?
- Необходимо чтобы был установлен Docker в машине где вы хотите проверить работу
- Перейти в папку где находится файлы (cd ..)
- Написать команду "docker build -t <название образа> ."
- Написать команду "docker run -d -p 8080:8080 <название образа>"
- Проверить по http://localhost:8080/hallo или http://localhost:8080/actuator/health 


## 5. Docker compose


Чтобы написать Dockerfile я использовал Multi-stage build чтобы уменшить размер образа и удалось уменшить образ с 492 МБ до 82 МБ. Все условия были выполнены по Dockerfile. 
Далее написал docker-compose.yaml файл и создал .env файл чтобы хранить секреты. Это я сделал потому что писать чувствительные данные в docker-compose не является best practice и небезопасно. Подробнее было расписано в комментах в файлах.

Что сделать чтобы проверить работу ?
- Необходимо чтобы был установлен Docker в машине где вы хотите проверить работу
- Перейти в папку где находится файлы (cd ..)
- В файле .env.dev написать необходимые данные DB_NAME, DB_USER, DB_PASSWORD
- Далее docker-compose up -d (Возможно с первого раза не получится запустить app, если не запуститься то необходимо еще раз  запустить эту команду "docker-compose up -d"). 
- Проверить работоспособность в браузере или в терминале
curl localhost:8000/api/v1/users \
  -X POST -d '{"firstName":"Docker","lastName":"testUser"}' \
  --header "Content-Type: application/json"

curl localhost:8000/api/v1/users/1
