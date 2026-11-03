$ErrorActionPreference = 'Stop'

$securePassword = Read-Host 'Enter MySQL root password' -AsSecureString
$pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)

try {
    $plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
    [Environment]::SetEnvironmentVariable('DB_PASSWORD', $plainPassword, 'User')
    Write-Host 'DB_PASSWORD saved for the current Windows user.' -ForegroundColor Green
}
finally {
    if ($pointer -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
    }
    $plainPassword = $null
}

Start-Sleep -Seconds 2
