
[string]$upn = Read-Host "Please provide 'userPrincipalName' to update SPO user properties"
$msolUserProperty = Get-MsolUser -UserPrincipalName $upn | select *
$pnpUserProperty = Get-PnPUserProfileProperty -Account $upn | select DisplayName -ExpandProperty UserProfileProperties

foreach ($m in $msolUserProperty){
    foreach ($p in $pnpUserProperty){
        
        if ($m.FirstName -ne $p.FirstName){
            Write-Host "FirstName updated!" -fore Cyan
            Set-PnPUserProfileProperty -Account $upn -PropertyName 'FirstName' -Value $m.FirstName
        }
        if ($m.Title -ne $p.Title){
            Write-Host 'Title updated!' -fore Cyan
            Set-PnPUserProfileProperty -Account $upn -PropertyName 'Title' -Value $m.Title
        }
         if ($m.LastName -ne $p.LastName){
            Write-Host 'LastName updated!' -fore Cyan
            Set-PnPUserProfileProperty -Account $upn -PropertyName 'LastName' -Value $m.LastName
        }
         if ($m.Department -ne $p.Department){
            Write-Host 'Department updated!' -fore Cyan
            Set-PnPUserProfileProperty -Account $upn -PropertyName 'Department' -Value $m.Department
        }
        if ($m.PhoneNumber -ne $p.WorkPhone){
            Write-Host 'WorkPhone updated!' -fore Cyan
            Set-PnPUserProfileProperty -Account $upn -PropertyName 'WorkPhone' -Value $m.PhoneNumber
        }
    } 
}
Write-Output "Finished updating user properties in SPO!"