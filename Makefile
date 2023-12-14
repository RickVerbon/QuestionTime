PROJECT_NAME = qtime
FRONTEND_DIR = frontend

factory-reset: stop clean rebuild makemigrations migrate fixtures build-frontend

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

build-frontend:
	cd $(FRONTEND_DIR) && npm install && npm run build # install dependencies and build static files

dev:
	cd $(FRONTEND_DIR) && npm run dev

.PHONY: factory-reset migrate tail superuser build-frontend dev bash
