# IN3101 Lab 02 — Library REST API

A simple REST API for managing library books, developed for IN3101 Enterprise Application Development Lab Sheet 02.

## Technology Stack

- Java 21
- Spring Boot 4.1.1
- Spring Web MVC
- Spring Data JPA
- Jakarta Validation
- MySQL 8
- springdoc OpenAPI and Swagger UI
- Maven

## Prerequisites

- JDK 21
- MySQL Server 8
- PowerShell or another terminal

The Maven Wrapper is included, so a separate Maven installation is optional.

## Database Setup

Create the database:

```sql
CREATE DATABASE IF NOT EXISTS library_db;
```

The application connects as `root` to `jdbc:mysql://localhost:3306/library_db`. Set the password as an environment variable before starting the application:

```powershell
$env:DB_PASSWORD = "your-mysql-password"
```

Do not place the real password in `application.properties` or commit it to Git. Hibernate creates or updates the `book` table automatically.

## Build and Run

```powershell
.\mvnw.cmd clean test
.\mvnw.cmd package
.\mvnw.cmd spring-boot:run
```

The API is available at `http://localhost:8080`.

## REST Endpoints

| Method | Endpoint | Purpose | Success Status |
|---|---|---|---|
| GET | `/api/books` | List all books | `200 OK` |
| GET | `/api/books/{id}` | Get one book | `200 OK` |
| POST | `/api/books` | Create a book | `201 Created` |
| PUT | `/api/books/{id}` | Update a book | `200 OK` |
| DELETE | `/api/books/{id}` | Delete a book | `204 No Content` |

Requests for missing books return `404 Not Found`. Invalid request bodies return `400 Bad Request`.

## API Documentation

Swagger UI: `http://localhost:8080/swagger-ui.html`

OpenAPI JSON: `http://localhost:8080/v3/api-docs`

## Postman Collection

Import [`postman/IN3101 Lab02 - 234006L.postman_collection.json`](postman/IN3101%20Lab02%20-%20234006L.postman_collection.json) into Postman and run its requests in order against the local application.
