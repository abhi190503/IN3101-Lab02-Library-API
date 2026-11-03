# Submission evidence

Place the eight genuine screenshots in `submission/screenshots` using these exact filenames:

1. `S1-Postman-Create-Book.png`
2. `S2-Postman-List-All-Books.png`
3. `S3-Postman-Get-One-Book.png`
4. `S4-Postman-Update-Book.png`
5. `S5-Postman-Delete-Book.png`
6. `S6-Postman-Deleted-Book.png`
7. `S7-Postman-Validation.png`
8. `S8-Swagger-Documentation.png`

Then generate the final PDF from the project root:

```powershell
.\submission\generate-pdf.ps1 -RepositoryUrl "https://github.com/USERNAME/IN3101-Lab02-Library-API"
```

The script refuses to generate the PDF if the repository URL is not a real GitHub URL or any screenshot is missing.
