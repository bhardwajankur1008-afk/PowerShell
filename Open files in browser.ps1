$TenantURL =  "https://zariii.sharepoint.com/"
$Credential = Get-Credential
Connect-PnPOnline -Url $TenantURL -Credentials $Credential
$site = Get-PnPTenantSite -Filter "Url -like '$TenantURL' -and Url -notlike 'portals/hub'"
$FeatureID= "8a4b8de2-6fd8-41e9-923c-c7c3c00f8295"

Foreach ($s in $site){
    try
    {
        Connect-PnPOnline -Url $s.Url -Credentials $Credential
        Write-Host "Connected to:"$($s.Url) -f Green
        Write-Host "Disabling features on:"$($s.Url) -f Yellow
        Write-Host "------------------------------------------"
        # Use Enable-PnpFeature if want to open files in desktop client apps"
        Disable-PnPFeature -Identity $FeatureID -Force -Scope Site -ErrorAction Continue
        Disconnect-PnPOnline
    }
    catch
    {
        Write-Host "Something went wrong, cannot connect to:"$s.Url -f Red
    }
}
   
