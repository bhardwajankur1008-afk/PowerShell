
$user = Get-Mailbox -ResultSize unlimited | where {$_.RecipientTypeDetails -eq "UserMailbox"} | select UserPrincipalName
Write-Host "MRM will initializing on following total mailboxes =" $user.Count -fore Yellow

foreach($u in $user){
    Write-Host $u.UserPrincipalName -Fore Green
    Start-ManagedFolderAssistant -Identity $u.UserPrincipalName
}
Write-Output "Task finished!"