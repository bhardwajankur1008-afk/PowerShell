
$roomList = Get-DistributionGroup -RecipientTypeDetails RoomList | select DisplayName, PrimarySmtpAddress
$i = 0

foreach ($r in $roomList)
{
    #$i += 1
    #Write-Progress -Activity "Searching room lists" -Status "Progress:" -PercentComplete ($i/$roomList.count*100)
    Write-Host ""
    Write-Host "----->"$r.DisplayName -f Yellow
    $member = Get-DistributionGroupMember -Identity $r.PrimarySmtpAddress | Select Name
    Write-Output $member.Name
}
