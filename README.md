# Deploy-Selenium

Deploy drivers selenium and chrome via PowerShell.

🚀 To quickly install or update all drivers and chromium of the appropriate version, use the following command in your terminal:

```PowerShell
Invoke-Expression(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/Lifailon/Deploy-Selenium/rsa/Deploy-Selenium-Drivers.ps1")
```

### 🎉 Example:

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

### 📑 Example connection and work

Example of connecting a set of drivers and working with selenium via PowerShell:

```PowerShell
$path = "$home\Documents\Selenium\"
$ChromeDriver = "$path\ChromeDriver.exe"
$WebDriver = "$path\WebDriver.dll"
$SupportDriver = "$path\WebDriver.Support.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
Add-Type -Path $SupportDriver
try {
    $ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
    $ChromeOptions.BinaryLocation = $Chromium
    $ChromeOptions.AddArgument("start-maximized")
    $ChromeOptions.AcceptInsecureCertificates = $True
    #$ChromeOptions.AddArgument("headless")
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
    Write-Host "Result: $result" -ForegroundColor Green
}
finally {
    $Selenium.Close()
    $Selenium.Quit()
}
```

Search for calculator in the search string, execute **22+33** using the click and output the result to the console:

```PowerShell
Starting ChromeDriver 114.0.5735.90 (386bc09e8f4f2e025eddae123f36f6263096ae49-refs/branch-heads/5735@{#1052}) on port 6996
Only local connections are allowed.
Please see https://chromedriver.chromium.org/security-considerations for suggestions on keeping ChromeDriver safe.
ChromeDriver was started successfully.
[15440:21824:1023/144544.425:ERROR:chrome_browser_cloud_management_controller.cc(162)] Cloud management controller initialization aborted as CBCM is not enabled.

DevTools listening on ws://127.0.0.1:6999/devtools/browser/fa82d6e0-a664-48da-b9ea-e4aecbf67a23
Result: 55
```
