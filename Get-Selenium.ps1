$path = "$home\Documents\Selenium\"
$ChromeDriver = "$path\ChromeDriver.exe"
$WebDriver = "$path\WebDriver.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$ChromeOptions.BinaryLocation = $Chromium
$ChromeOptions.AddArgument("start-maximized")
$ChromeOptions.AcceptInsecureCertificates = $True
$Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriver, $ChromeOptions)

$Selenium.Navigate().GoToUrl("https://google.com")
$Search = $Selenium.FindElements([OpenQA.Selenium.By]::Name("q")) # XPath('//*[@name="q"]'))
$Search.SendKeys("calculator online")
$Search.SendKeys([OpenQA.Selenium.Keys]::Enter)

Start-Sleep 1
$div = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("div"))
$2 = $div | Where-Object ComputedAccessibleLabel -like "2"
$2.Click()
$2.Click()
$plus = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="XSr6wc"]'))
$plus.Click()
$3 = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="KN1kY"]'))
$3.Click()
$3.Click()
$sum = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="Pt8tGc"]'))
$sum.Click()
$result = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="VssY5c"]')).Text
Write-Host "Result: $result"

#$Selenium.Close()
#$Selenium.Quit()

<# Example output:
PS C:\Users\lifailon\Desktop> . 'C:\Users\lifailon\Desktop\Get-Selenium.ps1'
Starting ChromeDriver 120.0.6073.0 (b9a0baaa9d39b6608d67b343c78d06f7989ce7ac-refs/branch-heads/6073@{#1}) on port 57048
Only local connections are allowed.
Please see https://chromedriver.chromium.org/security-considerations for suggestions on keeping ChromeDriver safe.
ChromeDriver was started successfully.
DevTools listening on ws://127.0.0.1:57051/devtools/browser/44c9b891-681b-4b8f-9317-affb3af5586d
Result: 55
#>