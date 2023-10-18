# Deploy-Selenium

Deploy drivers selenium and chrome via PowerShell.

🚀 Quick install or update to latest version of chrome drivers and chromium corresponding version.

![Image alt](https://github.com/Lifailon/Deploy-Selenium/blob/rsa/Example.gif)

### 📚 File composition:

```PowerShell
PS C:\Users\lifailon\Documents\Selenium> (pwd).Path
C:\Users\lifailon\Documents\Selenium
PS C:\Users\lifailon\Documents\Selenium> ls

Directory: C:\Users\lifailon\Documents\Selenium

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          18.10.2023    12:39                chrome-win32
-a---          26.05.2023    18:39       12273664 chromedriver.exe
-a---          15.10.2023    16:47        4276224 WebDriver.dll
-a---          15.10.2023    16:47          33792 WebDriver.Support.dll
```

### Connection example

Example of connecting a set of drivers for your PowerShell scripts:

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
```

**Example of working with selenium via PowerShell:**

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
```
