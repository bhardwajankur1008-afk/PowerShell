# To check delegation on shared mailbox

$sharedMailbox = Get-Mailbox -ResultSize unlimited -RecipientTypeDetails "SharedMailbox" | Select-Object WindowsEmailaddress, Name
$result = @()

Foreach ($s in $sharedMailbox){
    Write-Host ("Checking delegation for : " + $s.Name) -ForegroundColor Green
    $delegation = Get-RecipientPermission -Identity $($s.Name) | Where-Object {$_.Trustee -ne "NT AUTHORITY\SELF"} | Select-Object Trustee, AccessRights
    
    $hash = [Ordered]@{
        SharedMailbox = $s.WindowsEmailaddress
        Delegate = if ($null -eq $delegation.Trustee) {
            "No delegation found"
        }
        else {
            ($delegation.Trustee | Out-String).Trim()
        }
        SendAs = if ($null -eq $delegation.AccessRights) {
            "No"
        } 
        else {
                "Yes"
        } 
    }
           
    $result += New-Object psobject -Property $hash
}
$result | export-csv d:\delegation.csv -NoTypeInformation
Write-Output "Script completed !"
