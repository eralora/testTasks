## 5. Docker compose


Чтобы написать Dockerfile я использовал Multi-stage build чтобы уменшить размер образа и удалось уменшить образ с 492 МБ до 82 МБ. Все условия были выполнены по Dockerfile. 
Далее написал docker-compose.yaml файл и создал .env.dev файл чтобы хранить секреты. Это я сделал потому что писать чувствительные данные в docker-compose не является best practice и небезопасно. Подробнее было расписано в комментах в файлах.

Что сделать чтобы проверить работу ?
- Необходимо чтобы был установлен Docker в машине где вы хотите проверить работу
- Перейти в папку где находится файлы (cd ..)
- В файле .env.dev написать необходимые данные DB_NAME, DB_USER, DB_PASSWORD
- Далее docker-compose up -d
- Проверить работоспособность в браузере или в терминале
curl localhost:8000/api/v1/users \
  -X POST -d '{"firstName":"Docker","lastName":"testUser"}' \
  --header "Content-Type: application/json"

curl localhost:8000/api/v1/users/1