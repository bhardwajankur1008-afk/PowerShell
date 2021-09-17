# Get mailbox size of all users mailboxes
Write-Warning "Please wait while script is running!"
# setting up an empty array to export the data in csv file
$result = @()

$users = Get-Mailbox -ResultSize unlimited | where { $_.RecipientTypeDetails -eq "UserMailbox"} | select UserPrincipalName, ArchiveStatus

foreach ($u in $users) {
    # Getting data from primary mailboxes.
    Write-Host "Getting primary mailbox size of >>" $u.UserPrincipalName -fore Cyan
    $primaryMailboxSize = Get-EXOMailboxStatistics -Identity $u.UserPrincipalName | select TotalItemSize

    # checking whether mailbox has archive enabled.
    if ($u.ArchiveStatus -eq "Active") {
        Write-Host "Getting archive mailbox size of >>" $u.UserPrincipalName -fore Green
        $archiveMailboxSize = Get-EXOMailboxStatistics -Identity $u.UserPrincipalName -Archive | select TotalItemSize
    }
    # setting up hash table to obtain the data in correct format.
    $properties = [ordered]@{
        "Mailbox Name" = $u.UserPrincipalName
        "(Primary) Mailbox size" = $primaryMailboxSize.TotalItemSize
        "(Archive) Mailbox size" = $archiveMailboxSize.TotalItemSize
    }

    $result += New-Object psobject -Property $properties
    
}
$result | Export-Csv -Path D:\mailboxsize.csv -NoTypeInformation
Write-Output "-------------------------------------------------------"
Write-Host "mailboxsize.csv file generated in D drive." -fore Yellow
Write-Output "-------------------------------------------------------"