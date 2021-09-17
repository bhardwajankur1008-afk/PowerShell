
$AdminSiteURL="https://zariii-admin.sharepoint.com"
$user = Read-Host "Which user would you like to check?"
$Sites = Get-SPOSite -Limit ALL
$cred = Get-Credential
[int]$count = 0
$output = @()

Connect-SPOService -url $AdminSiteURL -Credential $cred
Write-Host "Gathering data.....!" -f Yellow

Foreach ($Site in $Sites) {
    try
    {
        $data = Get-SPOUser -Site $Site.Url -LoginName $cred.UserName | Select DisplayName, LoginName
        if ($data.LoginName -eq $user) {
            $count ++
            $property = @{
                "Site URLs" = $($site.Url)
            }
        }
        $output += New-Object psobject -Property $property  
    }
   
    catch
    {
        Write-Host "Something went wrong. We couldn't access:"$site.Url -f Green
    }  
}
Write-Host "--------------------------------------------" -f Cyan
Write-Host "'$user' belongs to '$count' following sites." -f Yellow
Write-Output $output



