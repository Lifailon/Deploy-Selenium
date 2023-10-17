$path = "C:\Users\Lifailon\Documents\Selenium"
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