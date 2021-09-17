
[string]$member = Read-Host "Member name"
[string]$ddl = Read-Host "Dynamic distribution group name"
$ddlfull = Get-DynamicDistributionGroup -Identity $ddl | select RecipientFilter, RecipientContainer
$members = Get-Recipient -RecipientPreviewFilter $ddlfull.RecipientFilter -OrganizationalUnit $ddlfull.RecipientContainer | select PrimarySmtpAddress

if($members -match "$member"){
    Write-Host "$member is part of $ddl group." -fore Yellow
}
else{
    Write-Host "$member is not part of $ddl group." -fore Cyan
}
