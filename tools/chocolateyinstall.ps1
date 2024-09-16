$packageName = 'gopher.security.app'
$msiUrl = 'https://s3.amazonaws.com/public.gopher.security/apps/release/windows/GopherSecurity-windows-0.0.2-17-amd64-release.msi'  # Replace with your S3 URL
$msiFile = Join-Path $env:TEMP 'myinstaller.msi'

# Download the MSI from S3
Write-Host "Downloading MSI from S3: $msiUrl"
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($msiUrl, $msiFile)

# Install the MSI silently
$msiArgs = @"
    /qn /norestart /i
"@
Start-ChocolateyProcessAsAdmin "msiexec /i `"$msiFile`" $msiArgs"

# Clean up the downloaded MSI
Remove-Item $msiFile -Force
