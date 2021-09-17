
do {
    $path = Read-host "Type the full path of csv file expample: D:\somefile.csv"
    $data = import-csv -Path $path
}
until ((Test-Path $path) -and $path -match '.csv')

$data | ForEach {

        Write-Host ("Updating distribution list: " + $_.SamAccountName) -fore Green

        Set-ADGroup -identity $_.SamAccountName -Remove @{"ProxyAddresses" = "SMTP:" + $_.Mail + "@osius.com"} -Add @{"ProxyAddresses" = "SMTP:" + $_.Mail + "@xxxx.com"} -ErrorAction SilentlyContinue

        Out-File logs.txt -InputObject $_.SamAccountName -Append
}

Write-Output "Completed !!!"
