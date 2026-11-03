param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^https://github\.com/[^/]+/[^/]+/?$')]
    [string]$RepositoryUrl
)

$ErrorActionPreference = 'Stop'
$submissionDirectory = $PSScriptRoot
$projectDirectory = Split-Path -Parent $submissionDirectory
$screenshotDirectory = Join-Path $submissionDirectory 'screenshots'
$outputPdf = Join-Path $projectDirectory '234006L_IN3101_Lab02.pdf'
$temporaryHtml = Join-Path $submissionDirectory 'submission-preview.html'

$pages = @(
    @{ Heading = 'S1 - Postman Create Book'; File = 'S1_Postman_Create.png' },
    @{ Heading = 'S2 - Postman List All Books'; File = 'S2_Postman_List.png' },
    @{ Heading = 'S3 - Postman Get One Book'; File = 'S3_Postman_GetOne.png' },
    @{ Heading = 'S4 - Postman Update Book'; File = 'S4_Postman_Update.png' },
    @{ Heading = 'S5 - Postman Delete Book'; File = 'S5_Postman_Delete.png' },
    @{ Heading = 'S6 - Postman Deleted Book'; File = 'S6_Postman_NotFound.png' },
    @{ Heading = 'S7 - Postman Validation'; File = 'S7_Postman_Validation.png' },
    @{ Heading = 'S8 - Swagger Documentation'; File = 'S8_Swagger_Documentation.png' }
)

$missingFiles = $pages | Where-Object { -not (Test-Path -LiteralPath (Join-Path $screenshotDirectory $_.File)) }
if ($missingFiles) {
    $names = ($missingFiles | ForEach-Object File) -join ', '
    throw "Cannot create a genuine submission PDF. Missing screenshots: $names"
}

$encodedRepositoryUrl = [System.Net.WebUtility]::HtmlEncode($RepositoryUrl)
$sections = foreach ($page in $pages) {
    $imagePath = (Join-Path $screenshotDirectory $page.File).Replace('\', '/')
    $encodedHeading = [System.Net.WebUtility]::HtmlEncode($page.Heading)
    "<section class='evidence'><h2>$encodedHeading</h2><img src='file:///$imagePath' alt='$encodedHeading'></section>"
}

$html = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>234006L - IN3101 Lab 02</title>
<style>
  @page { size: A4 landscape; margin: 14mm; }
  * { box-sizing: border-box; }
  body { margin: 0; color: #000; background: #fff; font-family: Arial, sans-serif; }
  .cover, .evidence { height: 175mm; page-break-after: always; break-after: page; }
  .cover { display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; }
  .cover h1 { margin: 0 0 10mm; font-size: 28pt; }
  .cover h2 { margin: 2mm 0; font-size: 20pt; }
  .details { margin-top: 14mm; text-align: left; font-size: 15pt; line-height: 1.8; }
  .details a { color: #000; }
  .evidence { display: flex; flex-direction: column; }
  .evidence h2 { height: 12mm; margin: 0 0 4mm; font-size: 18pt; }
  .evidence img { display: block; max-width: 100%; max-height: 155mm; margin: auto; object-fit: contain; }
  .evidence:last-child { page-break-after: auto; break-after: auto; }
</style>
</head>
<body>
<section class="cover">
  <h1>University of Moratuwa</h1>
  <h2>Faculty of Information Technology</h2>
  <h2>IN3101 - Enterprise Application Development</h2>
  <h2>Lab Sheet 02 - Building a REST API with Spring Boot</h2>
  <div class="details">
    <div><strong>Student Name:</strong> Abhinaya Jeyakumar</div>
    <div><strong>Index Number:</strong> 234006L</div>
    <div><strong>GitHub Repository:</strong> <a href="$encodedRepositoryUrl">$encodedRepositoryUrl</a></div>
  </div>
</section>
$($sections -join "`n")
</body>
</html>
"@

Set-Content -LiteralPath $temporaryHtml -Value $html -Encoding utf8

$browserCandidates = @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
)
$browser = $browserCandidates | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
if (-not $browser) {
    throw 'Microsoft Edge or Google Chrome is required to print the submission PDF.'
}

$htmlUri = [System.Uri]::new($temporaryHtml).AbsoluteUri
& $browser --headless --disable-gpu --no-pdf-header-footer --allow-file-access-from-files "--print-to-pdf=$outputPdf" $htmlUri
if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $outputPdf)) {
    throw 'The browser did not produce the PDF.'
}

Write-Output "Created $outputPdf"
