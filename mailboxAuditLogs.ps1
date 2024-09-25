$mailboxs = Get-MailBox -resultsize unlimited | select UserPrincipalName
$result = @()

foreach ($m in $mailboxs)
{
    $audit = Search-MailboxAuditLog -StartDate ([system.DateTime]::Now.AddDays(-30)) -EndDate ([system.DateTime]::Now.AddDays(+1)) -Operations MailboxLogin -Identity $m.UserPrincipalName -ShowDetails| where-object {$_.ClientInfoString -like "*Client=Microsoft.Exchange.Mapi;*" -or $_.ClientInfoString -like "*Client=Microsoft.Exchange..Autodiscover;*" }| select LogonUserDisplayName, ClientInfoString, LastAccessed, clientIPAddress -First 1
    Write-Host "Processing mailbox audit logs ->"$m.UserPrincipalName -ForegroundColor Cyan
    $property = [ordered]@{
        LogonUserDisplayName = $audit.LogonUserDisplayName;
        ClientInfoString = $audit.ClientInfoString;
        LastAccessed = $audit.LastAccessed;
        clientIPAddress = $audit.clientIPAddress
    }
    $result += New-Object psobject -Property $property
}
$result | Export-Csv -Path c:\report.csv -NoTypeInformation
