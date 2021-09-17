#$TenantUrl = Read-Host "Enter the SharePoint admin center URL"
#$LogFile = [Environment]::GetFolderPath("Desktop") + "\OneDriveSites.log"
#Connect-SPOService -Url $TenantUrl
$sites = Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Select -ExpandProperty Url
read-host -assecurestring | convertfrom-securestring | out-file C:\mysecurestring.txt
$username = "b.ankur@wicdata.site"
$password = Get-Content 'C:\mysecurestring.txt' | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

Foreach($site in $sites){
    Write-Host $site -fore Green
    Connect-PnPOnline -Url $site -Credentials $cred
    $Lists = Get-PnPList | Where {$_.Hidden -eq $false}
       
    foreach($list in $Lists){
        Set-PnPList -Identity $list -EnableVersioning $True -MajorVersions 50
        Write-host -f Yellow "Configured Versioning on List:"$list.Title     
    }
}
