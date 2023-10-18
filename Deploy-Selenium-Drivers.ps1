### Creat directory
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

### Download Nuget
$nuget = "$temp\nuget.exe"
Invoke-RestMethod https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nuget

### Download Selenium WebDriver and Support
Set-Location $temp
Invoke-Expression "$nuget install Selenium.WebDriver" > $null
Invoke-Expression "$nuget install Selenium.Support" > $null

### Check download WebDriver
$WebDriver = $(Get-ChildItem "$temp\Selenium.WebDriver.*\lib\*\*.dll").FullName
$WebDriverVersion = $WebDriver -replace ".+Selenium.WebDriver.|\\.+"
if (Test-Path $WebDriver) {
    Write-Host "Install Selenium WebDriver: True. Version: $WebDriverVersion." -ForegroundColor Green
} else {
    Write-Host "Install Selenium WebDriver: False" -ForegroundColor Red
}

### Check download Support Driver
$WebDriverSupport = $(Get-ChildItem "$temp\Selenium.Support.*\lib\*\*.dll").FullName
$SupportVersion = $WebDriverSupport -replace ".+Selenium.Support.|\\.+"
if (Test-Path $WebDriverSupport) {
    Write-Host "Install Selenium WebDriver: True. Version: $SupportVersion." -ForegroundColor Green
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
### Download last version WebDriver and Chromium
    Write-Host "Not found chromium build for latest chrome driver: $LatestChromeDriver" -ForegroundColor Red
    Write-Host "Download last verison Chrome Driver and Chromium" -ForegroundColor Green
    Remove-Item $ChromeDriverPath -Force -Recurse
    $ChromeDriverUrl = ((Invoke-RestMethod https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json
    ).versions.downloads.chromedriver | Where-Object platform -like win32)[-1]
    $ChromiumUrl = ((Invoke-RestMethod https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json
    ).versions.downloads.chrome | Where-Object platform -like win32)[-1]
    $DriverVer = $ChromeDriverUrl.url -replace ".+testing/|/.+"
    $ChromiumVer = $ChromiumUrl.url -replace ".+testing/|/.+"
    $DriverZip = "$temp\WebDriver-$DriverVer.zip"
    $ChromiumZip = "$temp\Chromium-$ChromiumVer.zip"
    Invoke-RestMethod -Uri ($ChromeDriverUrl.url) -OutFile $DriverZip
    Invoke-RestMethod -Uri ($ChromiumUrl.url) -OutFile $ChromiumZip
    Expand-Archive -Path $DriverZip -DestinationPath $temp
    $ChromeDriver = (Get-ChildItem "$temp\*chromedriver*\*.exe").FullName
    Expand-Archive -Path $ChromiumZip -DestinationPath $path
    Write-Host "Install Last Chrome Driver version: $DriverVer" -ForegroundColor Green
    Write-Host "Install Last Chromium version: $ChromiumVer" -ForegroundColor Green
}

# Copy main directrory and clear temp
Copy-Item $WebDriver $path
Copy-Item $WebDriverSupport $path
Copy-Item $ChromeDriver $path
Set-Location $home
Remove-Item $temp -Force -Recurse
Write-Host "Installation complete" -ForegroundColor Green