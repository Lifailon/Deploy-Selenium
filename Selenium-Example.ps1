$path = "$home\Documents\Selenium\"
$log = "$path\ChromeDriver.log"
$ChromeDriver = "$path\ChromeDriver.exe"
$WebDriver = "$path\WebDriver.dll"
$SupportDriver = "$path\WebDriver.Support.dll"
$Chromium = (Get-ChildItem $path -Recurse | Where-Object Name -like chrome.exe).FullName
Add-Type -Path $WebDriver
Add-Type -Path $SupportDriver
try {
    $ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions # создаем объект с настройками запуска браузера
    $ChromeOptions.BinaryLocation = $Chromium # передаем путь до исполняемого файла, который отвечает за запуск браузера
    $ChromeOptions.AddArgument("start-maximized") # добавляем аргумент, который позволяет запустить браузер на весь экран
    $ChromeOptions.AcceptInsecureCertificates = $True # игнорировать предупреждение на сайтах с не валидным сертификатом
    #$ChromeOptions.AddArgument("headless") # скрывать окно браузера при запуске
    $ChromeDriverService = [OpenQA.Selenium.Chrome.ChromeDriverService]::CreateDefaultService($ChromeDriver) # создаем объект настроек службы драйвера
    $ChromeDriverService.HideCommandPromptWindow = $True # отключаем весь вывод логирования драйвера в консоль (этот вывод нельзя перенаправить)
    $ChromeDriverService.LogPath = $log # указать путь до файла с журналом
    $ChromeDriverService.EnableAppendLog = $True # не перезаписывать журнал при каждом новом запуске
    #$ChromeDriverService.EnableVerboseLogging = $True # кроме INFO и ошибок, записывать DEBUG сообщения
    $Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeDriverService, $ChromeOptions) # инициализируем запуск с указанными настройками

    $Selenium.Navigate().GoToUrl("https://google.com")
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::Id('APjFqb'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::XPath('//*[@id="APjFqb"]'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::Name('q'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::XPath('//*[@name="q"]'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::ClassName('gLFyf'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::CssSelector('[jsname="yZiJbe"]'))
    $Search = $Selenium.FindElements([OpenQA.Selenium.By]::TagName('textarea')) | Where-Object ComputedAccessibleRole -eq combobox
    $Search.SendKeys("calculator online")
    $Search.SendKeys([OpenQA.Selenium.Keys]::Enter)

    Start-Sleep 1
    $div = $Selenium.FindElements([OpenQA.Selenium.By]::TagName("div"))
    $2 = $div | Where-Object {($_.ComputedAccessibleRole -eq "button") -and ($_.ComputedAccessibleLabel -eq "2")}
    $2.Click()
    $2.Click()
    $plus = $div | Where-Object {($_.ComputedAccessibleRole -eq "button") -and ($_.Text -eq "+")}
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