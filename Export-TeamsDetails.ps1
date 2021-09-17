
$AllTeamsInOrg = Get-Team | select GroupId, DisplayName
$output = @()
Write-Host "PLEASE WAIT! Processing following Teams:" -f Yellow
Write-Host ""

foreach ($team in $AllTeamsInOrg)
{
    Write-Host "-----> $($team.DisplayName)" -f Cyan
    $TeamOwner = (Get-TeamUser -GroupId $Team.GroupId | ?{$_.Role -eq "Owner"}).User
    $TeamGuests= (Get-TeamUser -GroupId $Team.GroupId | ?{$_.Role -eq "Guest"}).User
    $TeamMember = (Get-TeamUser -GroupId $team.GroupId | ?{$_.Role -eq "Member"}).User
    $TeamChannel = Get-TeamChannel -GroupId $team.GroupId | select DisplayName

    $property = [ordered]@{
        "DisplayName" = $($team.DisplayName)
        "Owner" = ($TeamOwner | Out-String).Trim()
        "Guest" = ($TeamGuests | Out-String).Trim()
        "Member" = ($TeamMember | Out-String).Trim()
        "TeamChannel" = ($TeamChannel.DisplayName | Out-String).Trim()
    }
    $output += New-Object psobject -Property $property
}
$output | Export-Csv -Path D:\TeamsData.csv -NoTypeInformation
