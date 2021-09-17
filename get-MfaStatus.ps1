
Write-Warning "Please wait! script is running....."
$users = Get-Mailbox -ResultSize Unlimited | Where {$_.RecipientType -eq "Usermailbox"} | select UserPrincipalName
$output = @()

foreach ($u in $users)
{
    $mfaStatus = Get-MsolUser -UserPrincipalName $u.UserPrincipalName | Select -ExpandProperty StrongAuthenticationRequirements | Select State
    Write-Host "Processing $($u.UserPrincipalName)" -F Cyan
    
    $state = [Ordered]@{
        UPN = $($u.UserPrincipalName)
        MFA_Status = if ($mfaStatus.State -eq "Enabled"){Write-Output "Enabled"} else{Write-Output "Disabled"}
    }
    $output += New-Object psobject -Property $state
}
$output | Export-Csv D:\mfa_Status.csv -NoTypeInformation

