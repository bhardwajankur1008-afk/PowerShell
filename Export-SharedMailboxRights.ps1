
$file = Read-Host "Please provide full path of csv file. For example. 'c:\users\administrator\desktop\somefile.csv'"
$sharedMailbox = Import-Csv $file
$output = @()
Write-Host ""
Write-Host "Total mailboxes in csv file:"$sharedMailbox.count -f Yellow
Write-Warning "PLEASE WAIT! Processing following mailboxes:"
Write-Host ""

foreach ($s in $sharedMailbox)
{
    Write-Host "----->"$s.UserPrincipalName -f Green
    $permission = Get-MailboxPermission -Identity $s.UserPrincipalName | select identity,user,accessrights | where { ($_.User -like '*@*') }
    $exportPermission = [Ordered]@{
        Identity = ($permission.Identity | Out-String).Trim()
        User = ($permission.User | Out-String).Trim()
        AccessRights = ($permission.AccessRights | Out-String).Trim()
    }
    $output += New-Object psobject -Property $exportPermission
}
$output | Export-Csv -Path D:\SharedMailbox.csv -NoTypeInformation
Write-Host "Task Finished!" -f Yellow