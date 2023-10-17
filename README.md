# Deploy-Selenium

Deploy drivers selenium and chrome via PowerShell.

🚀 Quickly install or update to latest version of chrome driver and chromium corresponding version.

![Image alt](https://github.com/Lifailon/Deploy-Selenium/blob/rsa/Example.gif)

Example of connecting a set of drivers for your script PowerShell:

```PowerShell
$path = "$home\Documents\Selenium\"
$ChromeDriverPath = "$path\chromedriver.exe"
$WebDriver = "$path\WebDriver.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
$chromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$chromeOptions.BinaryLocation = $Chromium
$chromeOptions.AddArgument("start-maximized")
$chromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromeDriverPath, $chromeOptions)
$chromeDriver.Navigate().GoToUrl("https://www.google.com")
$chromeDriver.Quit()
```
Example of working with selenium via PowerShell:

```PowerShell
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
$plus = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="XSr6wc"]'))
$plus.Click()
$3 = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="KN1kY"]'))
$3.Click()
$sum = $Selenium.FindElement([OpenQA.Selenium.By]::CssSelector('[jsname="Pt8tGc"]'))
$sum.Click()

#$Selenium.Close()
#$Selenium.Quit()
```
