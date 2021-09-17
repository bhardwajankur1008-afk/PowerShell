
$licensedUser = Get-MsolUser -All | where {$_.isLicensed -eq "True"} | select UserPrincipalName
Write-Host "following list of users don't have 'Exchange online (P1)' enabled." -f Yellow
$count = 0


foreach ($u in $licensedUser) {
    $serviceStaus = Get-MsolUser -UserPrincipalName $u.UserPrincipalName | select -ExpandProperty Licenses | select -ExpandProperty ServiceStatus | select -ExpandProperty ServicePlan ProvisioningStatus

    foreach ($s in $serviceStaus) {
        if (($s.ServiceName -eq "EXCHANGE_S_STANDARD") -and ($s.ProvisioningStatus -eq "Disabled")) {
                Write-Host $u.UserPrincipalName -f Green
                $count ++
        }  
    }
}
Write-Host "Total count:"$count -f Yellow
