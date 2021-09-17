
[string]$groupName = Read-Host "Please provide security group name"
$group = Get-MsolGroup -SearchString $groupName | select DisplayName, ObjectId
$groupMember = Get-MsolGroupMember -GroupObjectId $group.ObjectId | select EmailAddress, GroupMemberType
Write-Host "Removing below users, sub groups from security group: $($group.DisplayName)" -Fore Yellow
$removedUsers = @()

foreach ($g in $groupMember)
{
    if ($g.GroupMemberType -eq "Group"){
        $groupId = Get-MsolGroup -SearchString $($g.EmailAddress) | select ObjectId
        Remove-MsolGroupMember -GroupObjectId $($group.ObjectId) -GroupMemberObjectId $($groupId.ObjectId) -GroupMemberType Group
    }
    if ($g.GroupMemberType -eq "User"){
        $groupMemberObjID = Get-MsolUser -UserPrincipalName $($g.EmailAddress) | select ObjectID

        foreach ($gr in $groupMemberObjID)
        {
            Remove-MsolGroupMember -GroupObjectId $($group.ObjectId) -GroupMemberObjectId $($gr.ObjectID)
        }   
    }
    $removedUsers += $($g.EmailAddress)
    Write-Host "Removing $($g.EmailAddress)" -fore Cyan
}
$removedUsers | Out-File -FilePath d:\removed.txt -Force
Write-Host "Task finished! 'RemovedUsers.txt' file generated in D drive." -Fore Green
