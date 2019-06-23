Write-Warning "Wait for while to complete this script, don't intrerupt the action."
$group = Get-UnifiedGroup -ResultSize unlimited | Select-Object DisplayName, PrimarySmtpAddress, ManagedBy
$result = @()

foreach($g in $group){

    Write-Host ("Checking members in Office group >>> " + $g.DisplayName) -ForegroundColor Green
    $member = Get-UnifiedGroupLinks -Identity $g.DisplayName -LinkType member | Select-Object Name
    
    foreach($m in $member){

        Write-Host ("Checking SMTP address >>> " + $m.Name) -fore Yellow
        $smtp = Get-Mailbox -Identity $m.Name | Select-Object PrimarySmtpAddress       
    }
   
    # $hash = [ordered]@{

    #     Group = $g.DisplayName
    #     GroupSMTP = $g.PrimarySmtpAddress
    #     GroupOwner = ($g.ManagedBy | Out-String).Trim()
    #     Member = ($member.Name | Out-String).Trim()
    #     MemberSMTP = $smtp.PrimarySmtpAddress
    # }
    $result += New-Object psobject -Property @{
        
            Group = $g.DisplayName
            GroupSMTP = $g.PrimarySmtpAddress
            GroupOwner = ($g.ManagedBy | Out-String).Trim()
            Member = ($member.Name | Out-String).Trim()
            MemberSMTP = $smtp.PrimarySmtpAddress
    }
}

$result | Export-Csv d:\officeGroup.csv -NoTypeInformation
# Write-Host "Script completed" -fore Cyan

