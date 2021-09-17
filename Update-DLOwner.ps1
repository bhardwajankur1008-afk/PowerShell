
$data = Import-Csv -Path D:\file.csv
$groupName = Read-Host "Which distribution group do you want to update? Please type full email address"
Write-Host "Adding following users as owner in distribution group..." -f Yellow -b Red
Write-Host ""

foreach($d in $data){
    Write-Host "==>> $($d.Owner) added" -f Cyan
    Set-DistributionGroup -Identity $groupName -ManagedBy @{Add=$($d.Owner)} -Confirm:$false
}