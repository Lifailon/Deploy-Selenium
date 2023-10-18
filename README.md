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

Search for calculator in the search string, execute **22+33** and output the result to the console:

```PowerShell
PS C:\Users\lifailon\Desktop> . 'C:\Users\lifailon\Desktop\Get-Selenium.ps1'
Starting ChromeDriver 120.0.6073.0 (b9a0baaa9d39b6608d67b343c78d06f7989ce7ac-refs/branch-heads/6073@{#1}) on port 57048
Only local connections are allowed.
Please see https://chromedriver.chromium.org/security-considerations for suggestions on keeping ChromeDriver safe.
ChromeDriver was started successfully.
[30100:30104:1018/133007.309:ERROR:policy_logger.cc(158)] :components\enterprise\browser\controller\chrome_browser_cloud_management_controller.cc(161) Cloud management controller initialization aborted as CBCM is not enabled. Please use the `--enable-chrome-browser-cloud-management` command line flag to enable it if you are not using the official Google Chrome build.

DevTools listening on ws://127.0.0.1:57051/devtools/browser/44c9b891-681b-4b8f-9317-affb3af5586d
Result: 55
```
