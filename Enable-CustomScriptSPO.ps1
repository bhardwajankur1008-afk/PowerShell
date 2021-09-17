$TenantURL =  "https://xxxxxx.sharepoint.com/"

#Get Credentials to connect
$Credential = Get-Credential

#Frame Tenant Admin URL from Tenant URL
$TenantAdminURL = $TenantURL.Insert($TenantURL.IndexOf("."),"-admin")

Connect-PnPOnline -Url $TenantAdminURL -Credentials $Credential

$site = Get-PnPTenantSite -Filter "Url -like '$TenantURL' -and Url -notlike 'portals/hub'"

foreach($s in $site){
    Write-Host "Processing site collection:" $s.url -fore Green
    $value = Get-SPOSite -Identity $s.url | select DenyAddAndCustomizePages
    
    if(($value.DenyAddAndCustomizePages) -eq "Disabled"){
        Write-Host "Custom scripts is already enabled:" $s.url -fore Yellow
    
    }
    else{
        Write-Host "Enabling custom scripts on:" $s.url -fore Cyan
        Set-SPOSite -Identity $s.url -DenyAddAndCustomizePages 0
    }
}


