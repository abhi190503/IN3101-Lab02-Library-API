# Submission evidence

Place the eight genuine screenshots in `submission/screenshots` using these exact filenames:

1. `S1_Postman_Create.png`
2. `S2_Postman_List.png`
3. `S3_Postman_GetOne.png`
4. `S4_Postman_Update.png`
5. `S5_Postman_Delete.png`
6. `S6_Postman_NotFound.png`
7. `S7_Postman_Validation.png`
8. `S8_Swagger_Documentation.png`

Then generate the final PDF from the project root:

```powershell
.\submission\generate-pdf.ps1 -RepositoryUrl "https://github.com/USERNAME/IN3101-Lab02-Library-API"
```

The script refuses to generate the PDF if the repository URL is not a real GitHub URL or any screenshot is missing.
