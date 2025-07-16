postgres:
	docker compose up -d

createdb: 
	docker exec -it postgres:15-alpine createdb --username=quanvm --owner=quanvm golang-db

dropdb:
	docker exec -it postgres:15-alpine dropdb --username=quanvm golang-db

migrateup:
	migrate -path database/migration -database "postgresql://quanvm:098poiA@@localhost:5432/golang-db?sslmode=disable" -verbose up

migratedown:
	migrate -path database/migration -database "postgresql://quanvm:098poiA@@localhost:5432/golang-db?sslmode=disable" -verbose down

migrate:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination database/mock/store.go github.com/quanminhvu/golang/database/sqlc Store 

.PHONY: createdb dropdb migrateup migratedown postgres migrate mock
