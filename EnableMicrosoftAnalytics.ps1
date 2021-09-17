
$data = Import-Csv -Path D:\file.csv

[string]$E1 = "zariii:SPE_E5"
[string]$E3 = "zariii:SPE_E5"
[string]$E5 = "zariii:SPE_E5"

$LO1 = New-MsolLicenseOptions -AccountSkuId $E1
$LO2 = New-MsolLicenseOptions -AccountSkuId $E3
$LO3 = New-MsolLicenseOptions -AccountSkuId $E5

foreach ($d in $data){

    if ((Get-MsolUser -UserPrincipalName $d.UserPrinciPalName | select -ExpandProperty Licenses | select AccountSkuId) -match $E1){
        Write-Host "Enabling Microsoft Analytics on >>" $d.UserPrinciPalName -fore Cyan
        Set-MsolUserLicense -UserPrincipalName $d.UserPrinciPalName -LicenseOptions $LO1
    }

    if ((Get-MsolUser -UserPrincipalName $d.UserPrinciPalName | select -ExpandProperty Licenses | select AccountSkuId) -match $E3){
        Write-Host "Enabling Microsoft Analytics on >>" $d.UserPrinciPalName -fore Cyan
        Set-MsolUserLicense -UserPrincipalName $d.UserPrinciPalName -LicenseOptions $LO3
    
    }

    if ((Get-MsolUser -UserPrincipalName $d.UserPrinciPalName | select -ExpandProperty Licenses | select AccountSkuId) -match $E5){
        Write-Host "Enabling Microsoft Analytics on >>" $d.UserPrinciPalName -fore Cyan
        Set-MsolUserLicense -UserPrincipalName $d.UserPrinciPalName -LicenseOptions $LO5
    
    }
    
    Write-Host "Script finished." -fore Yellow
}
    
