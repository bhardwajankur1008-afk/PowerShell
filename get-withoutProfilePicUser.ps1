
$allUsers = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited |select UserPrincipalName, Alias
$output = @()
$count = 0

Write-Host "Following users don't have pictures added:-" -f Yellow
Write-Host ""

Foreach($user in $allUsers) 
{
    $photo = Get-Userphoto -identity $user.UserPrincipalName -ErrorAction SilentlyContinue

    If($photo -eq $null){
        Write-Host $user.UserPrincipalName -f Cyan
        $output += $user
        $count ++
    }
    
}
$output | Export-Csv d:\userWithoutProfilePic.csv -NoTypeInformation
Write-Host ""
Write-Host "Total $count users don't have profile picture added. Find 'userWithoutProfilePic.csv' in D drive for list of users." -f Green -b red
