
$Group = Get-UnifiedGroup -ResultSize Unlimited | select DisplayName, PrimarySmtpAddress, ManagedBy
$result = @()
Write-Host "Total office 365 groups found:"($Group.DisplayName).count -f Cyan
Write-Host ""
Write-Warning "PLEASE WAIT! Processing following groups:"
Write-Host ""

Foreach($g in $Group){
    Write-Host ("-----> " + $g.DisplayName) -fore Green
    $allMember = Get-UnifiedGroupLinks -Identity $g.DisplayName -LinkType Member | select Name
    $prop = [Ordered]@{
        GroupName = $g.DisplayName
        GroupSMTP = $g.PrimarySmtpAddress
        Owner = ($g.ManagedBy | Out-String).Trim()
        Member = ($allMember.Name | Out-String).Trim()
    }
    $result += New-Object PsObject -Property $prop
}

$result | Export-Csv D:\Office.csv -NoTypeInformation
Write-Host "Task finished!" -f Yellow
