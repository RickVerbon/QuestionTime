PROJECT_NAME = qtime

factory-reset: stop clean rebuild makemigrations migrate fixtures

stop:
	docker-compose down

clean:
	docker-compose down -v --remove-orphans
	docker system prune -f

rebuild:
	docker-compose build
	docker-compose up -d

makemigrations:
	docker-compose run --rm app python manage.py makemigrations

migrate:
	docker-compose run --rm app python manage.py migrate

fixtures:
	docker-compose run --rm app python manage.py loaddata users.json
	docker-compose run --rm app python manage.py loaddata questions.json
	docker-compose run --rm app python manage.py loaddata answers.json

tail:
	docker-compose logs --tail 0 --follow

superuser:
	docker-compose run --rm app python3 manage.py createsuperuser --email admin@localhost --username admin

bash:
	docker-compose run --rm app bash

.PHONY: factory-reset migrate tail superuser
