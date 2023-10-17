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
