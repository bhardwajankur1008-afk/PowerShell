# Enable following if want to replace licenses on all users
# $users = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -eq "UserMailbox"} | select UserPrincipalName

# To replace licenses on specific users, please keep them in CSV file and update the file path in below line.
$users = Import-Csv -Path C:\Users\ankurb\Desktop\user.csv
[string]$standard = "xxxx:O365_BUSINESS_PREMIUM"
[string]$basic = "xxxx:O365_BUSINESS_ESSENTIALS"
[string]$kiosk = "xxxx:EXCHANGEDESKLESS"
[string]$e3 = "xxxx:ENTERPRISEPACK"
[string]$e1 = "xxxx:STANDARDPACK"
[string]$e5 = "xxxx:ENTERPRISEPREMIUM"
 
Foreach($u in $users){
    
    # Standard license is replaced by E3 license
    if((Get-MsolUser -UserPrincipalName $u.UserPrincipalName | select -ExpandProperty Licenses | select AccountSkuId) -match $e5){
        Write-Host "Replacing E3 with E5 license >" $u.UserPrincipalName -fore Yellow
        Set-MsolUserLicense -UserPrincipalName $u.UserPrincipalName -AddLicenses $e3 -RemoveLicenses $e5
        break
    }
    # Basic license is replaced by E1 license
    if ((Get-MsolUser -UserPrincipalName $u.UserPrincipalName | select -ExpandProperty Licenses | select AccountSkuId) -match $basic){
        Write-Host "Replacing basic license with E1 license >" $u.UserPrincipalName -fore Green
        Set-MsolUserLicense -UserPrincipalName $u.UserPrincipalName -AddLicenses $e1  -RemoveLicenses $basic
        break
    }
    # Kiosk license is replaced by E1 license
    if ((Get-MsolUser -UserPrincipalName $u.UserPrincipalName | select -ExpandProperty Licenses | select AccountSkuId) -match $kiosk){
        Write-Host "Replacing kiosk license with E1 license >" $u.UserPrincipalName -fore Cyan
        Set-MsolUserLicense -UserPrincipalName $u.UserPrincipalName -AddLicenses $e1  -RemoveLicenses $kiosk
        break
    }
    else{
        Write-Warning "Can't replace license on $($u.UserPrincipalName), Please try again after sometime."
    }
  
}
Write-Output "Task finished!"
