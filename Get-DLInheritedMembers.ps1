$count = 0
$group = "xxxxxx.PUBLICVM.COM"
$directMember = Get-DistributionGroupMember -Identity $group | select Name, RecipientType
Write-Host "Direct members count:"$directMember.Count -F Cyan
Write-Output $directMember.Name
Write-Host "---------------------------------------------------------------------------" -f Green
$count += $directMember.Count

ForEach ($d in $directMember) {
    # checking if member type is group, if yes, show members
    if ($d.RecipientType -eq "MailUniversalDistributionGroup") {
        Write-Host "$($d.Name) is inherited group and its members are:" -f Yellow
        $InheritGroupMember = Get-DistributionGroupMember -Identity $d.Name | select Name, RecipientType
        Write-Host "Direct members count:"$InheritGroupMember.Count -F Cyan
        Write-Output $InheritGroupMember.Name
        Write-Host "---------------------------------------------------------------------------" -f Green
        $count += $InheritGroupMember.Count
    }
}
Write-Host "Total direct and indirect members are:"$count -F Green
