### Main directory
$temp = "$home\Documents\Selenium-Temp\"
$path = "$home\Documents\Selenium\"
if ($(Test-Path $temp) -like "False") {
    New-Item -ItemType Directory -Path $temp
}

### Download Nuget
$nuget = "$temp\nuget.exe"
Invoke-RestMethod https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nuget

### Download Selenium WebDriver
Set-Location $temp
.$nuget install Selenium.WebDriver
$WebDriver = $(Get-ChildItem "$temp\Selenium.WebDriver.*\lib\*\*.dll").FullName
$TestSelenium = Test-Path $WebDriver
Write-Host "Install Selenium Driver: $TestSelenium" -ForegroundColor Yellow

### Get latest version
$LatestChromeDriver = Invoke-RestMethod https://chromedriver.storage.googleapis.com/LATEST_RELEASE
Write-Host "Latest Chrome Driver Version: $LatestChromeDriver" -ForegroundColor Green

### Download Latest ChromeDriver
$ChromeDriverZip = "$temp\ChromeDriver-$LatestChromeDriver.zip"
Invoke-RestMethod "https://chromedriver.storage.googleapis.com/$LatestChromeDriver/chromedriver_win32.zip" -OutFile $ChromeDriverZip
$ChromeDriverPath = $ChromeDriverZip -replace ".zip"
Expand-Archive -Path $ChromeDriverZip -DestinationPath $ChromeDriverPath
$ChromeDriver = (Get-ChildItem "$ChromeDriverPath\*.exe").FullName
$TestChrome = Test-Path $ChromeDriver
Write-Host "Install Latest Chrome Driver: $TestChrome (Version: $LatestChromeDriver)" -ForegroundColor Yellow

### Download Chromium
$url = (Invoke-RestMethod https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json
).versions.downloads.chrome | Where-Object platform -like win32 | Where-Object url -match $LatestChromeDriver
$ChromiumZip = "$temp\Chromium-$LatestChromeDriver.zip"
$ChromiumPath = "$temp\Chromium"
Invoke-RestMethod -Uri ($url.url) -OutFile $ChromiumZip
Expand-Archive -Path $ChromiumZip -DestinationPath $Path

# Copy main directrory and clear temp
if (($TestSelenium -like "True") -and ($TestChrome -like "True")) {
    Copy-Item $WebDriver $path
    Copy-Item $ChromeDriver $path
    Write-Host "Install Succesfull" -ForegroundColor Green
} else {
    Write-Host "Install Failed" -ForegroundColor Red
}