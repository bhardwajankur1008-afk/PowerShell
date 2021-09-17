#Clear-Host

Write-Warning "Please wait, don't make any changes in Active Directory."

Import-Module ActiveDirectory

$domain1 = Read-Host "Domain name for 'SMTP' exp: domain.com"

$domain2 = Read-Host "Domain name for 'smtp' exp: domain.com"

$array = @("krakesh@xxxx.com"
            "ssarkar@xxxx.com"
            "QMS@xxxx.com"
            "imulla@xxxx.com"
            "ktotapalli@xxxx.com"
            "sylestey@xxxx.com"
            "ewijaya@xxxx.com"
            "sgopaul@xxxx.com"
            "smannava@xxxx.com")

Get-ADUser -Filter {Enabled -eq $True} -Properties ProxyAddresses, SamAccountName | ForEach-Object {

    if ($_.ProxyAddresses -match ("SMTP:" + $_.SamAccountName + "@" + $domain1)) {

        if ($_.ProxyAddresses -match ("smtp:" + $_.SamAccountName + "@" + $domain2)) {

            if ($_.ProxyAddresses -match $arry) {

                Write-Host ("Proxy is already added, No action taken ! " + $_.SamAccountName)  -fore Red
            }
        }
    }
}
   
    else{
        
        Write-Host ("Adding and removing proxy: " + $_.SamAccountName) -fore Yellow
        Set-ADUser -Identity $_.SamaccountName -Add @{'ProxyAddresses' = "SMTP:" + $_.SamAccountName + "@" + $domain1} -Remove @{'ProxyAddresses' = "SMTP:" + $_.SamAccountName + "@" + $domain2}
        Set-ADUser -Identity $_.SamAccountName -Add @{'ProxyAddresses' = "smtp:" + $_.SamAccountName + "@" + $domain2}
    }


Write-Host "Script completed !!!" -fore Green

