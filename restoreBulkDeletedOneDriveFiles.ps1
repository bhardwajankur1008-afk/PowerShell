Connect-SPOService -Url https://your domain-admin.sharepoint.com/
Connect-PnPOnline -Url https://your domain.sharepoint.com/sites/test

$user = Read-Host "User name"
$InitialDeletedFiles = Get-PnPRecycleBinItem -firststage | ? {($_.DeletedDate -gt $restoreDate) -and ($_.DeletedByEmail -eq $user)}
$Initialcount = $InitialDeletedFiles.count
Write-Host "Total Original items in recyclebin: $Initialcount" -F Yellow

do
{
   Get-PnPRecycleBinItem -RowLimit 10000 | ? {($_.DeletedDate -gt $restoreDate) -and ($_.DeletedByEmail -eq $user)} | Restore-PnpRecycleBinItem -Force
   $CurrentDeletedFiles = Get-PnPRecycleBinItem -firststage | ? {($_.DeletedDate -gt $restoreDate) -and ($_.DeletedByEmail -eq $user)}
   $NewCount = $CurrentDeletedFiles.count
   Write-Host "Files left to restore:$NewCount" -F Cyan
}
while ($NewCount -gt 0)

Write-Host "Total files restored:$Initialcount" -f Yellow