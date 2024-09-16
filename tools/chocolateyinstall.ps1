$packageName = 'gopher.security.app'
$msiUrl = 'https://s3.amazonaws.com/public.gopher.security/apps/release/windows/GopherSecurity-windows-0.0.2-17-amd64-release.msi'  # S3 URL for the MSI
$msiFile = Join-Path $env:TEMP 'gophersecurity_installer.msi'

try {
    # Download the MSI from S3
    Write-Host "Downloading MSI from S3: $msiUrl"
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($msiUrl, $msiFile)

    # Check if MSI was downloaded successfully
    if (Test-Path $msiFile) {
        # Install the MSI silently
        Write-Host "Installing MSI: $msiFile"
        $msiArgs = "/qn /norestart /i `"$msiFile`""
        Start-ChocolateyProcessAsAdmin "msiexec $msiArgs"
    } else {
        throw "MSI download failed."
    }
} catch {
    Write-Host "An error occurred: $_"
    throw $_
} finally {
    # Clean up the downloaded MSI
    if (Test-Path $msiFile) {
        Write-Host "Cleaning up downloaded MSI."
        Remove-Item $msiFile -Force
    }
}
