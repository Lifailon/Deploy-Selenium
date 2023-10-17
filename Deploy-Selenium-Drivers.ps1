### Main directory
Set-Location $home
$temp = "$home\Documents\Selenium-Temp\"
if (Test-Path $temp) {
    Remove-Item $temp -Force -Recurse
    New-Item -ItemType Directory -Path $temp
} else {
    New-Item -ItemType Directory -Path $temp
}
$path = "$home\Documents\Selenium\"
if (Test-Path $path) {
    Remove-Item $path -Force -Recurse
}

### Download latest Nuget
$nuget = "$temp\nuget.exe"
Invoke-RestMethod https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nuget

### Download Selenium WebDriver
Set-Location $temp
Invoke-Expression "$nuget install Selenium.WebDriver" > $null
$WebDriver = $(Get-ChildItem "$temp\Selenium.WebDriver.*\lib\*\*.dll").FullName
if (Test-Path $WebDriver) {
    Write-Host "Install Selenium WebDriver: True" -ForegroundColor Green
} else {
    Write-Host "Install Selenium WebDriver: False" -ForegroundColor Red
}

### Get latest version ChromeDriver
$LatestChromeDriver = Invoke-RestMethod https://chromedriver.storage.googleapis.com/LATEST_RELEASE
Write-Host "Latest Version ChromeDriver: $LatestChromeDriver" -ForegroundColor Green

### Download Latest ChromeDriver
$ChromeDriverZip = "$temp\ChromeDriver-$LatestChromeDriver.zip"
Invoke-RestMethod "https://chromedriver.storage.googleapis.com/$LatestChromeDriver/chromedriver_win32.zip" -OutFile $ChromeDriverZip
$ChromeDriverPath = $ChromeDriverZip -replace ".zip"
Expand-Archive -Path $ChromeDriverZip -DestinationPath $ChromeDriverPath
$ChromeDriver = (Get-ChildItem "$ChromeDriverPath\*.exe").FullName
if  (Test-Path $ChromeDriver) {
    Write-Host "Install Latest ChromeDriver: True" -ForegroundColor Green
} else {
    Write-Host "Install Latest ChromeDriver: False" -ForegroundColor Red
}

### Download Chromium
$url = (Invoke-RestMethod https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json
).versions.downloads.chrome | Where-Object platform -like win32 | Where-Object url -match $LatestChromeDriver
if ($url) {
    $ChromiumZip = "$temp\Chromium-$LatestChromeDriver.zip"
    Invoke-RestMethod -Uri ($url.url) -OutFile $ChromiumZip
    Expand-Archive -Path $ChromiumZip -DestinationPath $Path
    Write-Host "Install Latest Chromium: True" -ForegroundColor Green
} else {
    Write-Host "Not found chromium build for latest chrome driver: $LatestChromeDriver" -ForegroundColor Red
}

# Copy main directrory and clear temp
Copy-Item $WebDriver $path
Copy-Item $ChromeDriver $path
Set-Location $home
Remove-Item $temp -Force -Recurse
Write-Host "Installation complete" -ForegroundColor Green