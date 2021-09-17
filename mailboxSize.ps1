# Get mailbox size of all users mailboxes
Write-Warning "Please wait while script is running!"
# setting up an empty array to export the data in csv file
$result = @()

$users = Get-Mailbox -ResultSize unlimited | where { $_.RecipientTypeDetails -eq "UserMailbox"} | select UserPrincipalName, ArchiveStatus

foreach ($u in $users) {
    # Getting data from primary mailboxes.
    Write-Host "Getting primary mailbox size of >>" $u.UserPrincipalName -fore Cyan
    $pmailboxInboxSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Folderscope Inbox | select folderSize
    $pmailboxSentSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Folderscope SentItems | select FolderSize
    $pmailboxCalendarSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Folderscope Calendar | select foldersize
    $pmailboxTaskSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Folderscope Tasks | select foldersize

    # checking whether mailbox has archive enabled.
    if ($u.ArchiveStatus -eq "Active") {
        Write-Host "Getting archive mailbox size of >>" $u.UserPrincipalName -fore Green
        $amailboxSizeInboxSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Archive -Folderscope Inbox | select foldersize
        $amailboxSizeSentSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Archive -Folderscope SentItems | select foldersize
        $amailboxSizeCalendarSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Archive -Folderscope Calendar | select foldersize
        $amailboxSizeTaskSize = Get-EXOMailboxFolderStatistics -Identity $u.UserPrincipalName -Archive -Folderscope Tasks | select foldersize
    }

    # setting up hash table to obtain the data in correct format.
    $properties = [ordered]@{
        "Mailbox Name" = $u.UserPrincipalName
        "(Primary)Mailbox inbox size" = ($pmailboxInboxSize.foldersize | Out-String).Trim()
        "(Primary)Mailbox sent item size" = $pmailboxSentSize.foldersize
        "(Primary)Mailbox calendar size" = ($pmailboxCalendarSize.foldersize | Out-String).Trim()
        "(Primary)Mailbox task size" = $pmailboxTaskSize.foldersize
        "(Archive)Mailbox inbox size" = $amailboxSizeInboxSize.foldersize
        "(Archive)Mailbox sent size" = $amailboxSizeSentSize.foldersize
        "(Archive)Mailbox calendar size" = $amailboxSizeCalendarSize.foldersize
        "(Archive)Mailbox task size" = $amailboxSizeTaskSize.foldersize
    }

    $result += New-Object psobject -Property $properties
    
}
$result | Export-Csv -Path .\mailboxsize.csv -NoTypeInformation
Write-Host "mailbox.csv file generated in directory where your PowerShell script resides." -fore Yellow 

