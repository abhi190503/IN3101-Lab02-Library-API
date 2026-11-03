# IN3101 Lab 02 - Library REST API

A Spring Boot REST API for managing books, prepared for IN3101 Enterprise Application Development Lab Sheet 02.

## Technology stack

- Java 21
- Spring Boot 4
- Spring Web MVC, Spring Data JPA and Jakarta Validation
- MySQL 8
- springdoc OpenAPI / Swagger UI
- Maven

## Database configuration

Create the database without deleting any existing data:

```sql
CREATE DATABASE IF NOT EXISTS library_db;
```

Set the MySQL root password only in the current terminal, so it is never committed:

```powershell
$env:DB_PASSWORD = "your-mysql-password"
```

The application connects to `jdbc:mysql://localhost:3306/library_db` and Hibernate creates or updates the `book` table.

## Build and run

```powershell
.\mvnw.cmd clean test
.\mvnw.cmd package
.\mvnw.cmd spring-boot:run
```

The API is available at `http://localhost:8080`.

## API endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/books` | List all books |
| GET | `/api/books/{id}` | Get one book |
| POST | `/api/books` | Create a book |
| PUT | `/api/books/{id}` | Update a book |
| DELETE | `/api/books/{id}` | Delete a book |

Swagger UI: `http://localhost:8080/swagger-ui.html`

OpenAPI JSON: `http://localhost:8080/v3/api-docs`
