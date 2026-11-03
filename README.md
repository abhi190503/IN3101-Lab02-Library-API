# IN3101 Lab 02 - Library REST API

This project is a simple REST API for managing books in a library. It was developed for IN3101 Enterprise Application Development Lab Sheet 02.

## Technologies Used

- Java 21
- Spring Boot 4.1.1
- Spring Web MVC
- Spring Data JPA
- Jakarta Validation
- MySQL
- Springdoc OpenAPI and Swagger UI
- Maven

## Project Structure

```text
src/
|-- main/
|   |-- java/lk/ac/mrt/fit/library_api/
|   |   |-- controller/BookController.java
|   |   |-- model/Book.java
|   |   |-- repository/BookRepository.java
|   |   |-- service/BookService.java
|   |   `-- LibraryApiApplication.java
|   `-- resources/application.properties
`-- test/java/lk/ac/mrt/fit/library_api/service/BookServiceTest.java
```

The application uses the controller, service, repository, and model layers. Book data is stored in MySQL.

## Database Setup

Create the MySQL database:

```sql
CREATE DATABASE IF NOT EXISTS library_db;
```

The application connects to MySQL on `localhost:3306` using the `root` user. Set the database password as an environment variable before running the application:

```powershell
$env:DB_PASSWORD = "your-mysql-password"
```

The database connection is configured in `src/main/resources/application.properties`. Hibernate creates or updates the `book` table when the application starts.

## Run the Application

Run the tests:

```powershell
.\mvnw.cmd clean test
```

Start the application:

```powershell
.\mvnw.cmd spring-boot:run
```

The API runs at `http://localhost:8080`.

## REST Endpoints

| Method | Endpoint | Description | Response |
|---|---|---|---|
| GET | `/api/books` | Get all books | `200 OK` |
| GET | `/api/books/{id}` | Get a book by ID | `200 OK` or `404 Not Found` |
| POST | `/api/books` | Add a new book | `201 Created` or `400 Bad Request` |
| PUT | `/api/books/{id}` | Update a book | `200 OK`, `400 Bad Request`, or `404 Not Found` |
| DELETE | `/api/books/{id}` | Delete a book | `204 No Content` or `404 Not Found` |

The `title` and `author` fields cannot be blank, and `price` cannot be negative.

## Swagger Documentation

After starting the application, the API documentation is available at:

- Swagger UI: `http://localhost:8080/swagger-ui.html`
- OpenAPI JSON: `http://localhost:8080/v3/api-docs`
