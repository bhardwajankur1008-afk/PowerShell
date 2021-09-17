cls
$ErrorActionPreference = "stop"
$blockedUser = Get-MsolUser -All | where {$_.BlockCredential -eq "True"} | Select DisplayName, UserPrincipalName, ObjectID
Write-Host "Total blocked sign in users found:"($blockedUser.DisplayName).count -f Green
Write-Host "Proceeding to remove users from Office 365 groups....." -f Yellow

foreach ($user in $blockedUser){
    $blockedUserMembership = Get-AzureADUserMembership -ObjectId $user.ObjectID | select DisplayName
    Write-Host "----------------------------" -f White
    Write-Host "---> User:"$user.DisplayName -f Cyan

    foreach ($group in $blockedUserMembership){
        Write-Host "-------> Group:"$group.DisplayName -f Green

        try
        {
            Remove-UnifiedGroupLinks -Identity $group.DisplayName -LinkType Members -Links $blockedUser.UserPrincipalName -cf:$false
        }
        catch
        {
            Write-Host "Something went wrong!" -f Red
        }
    }
}
