$c = Get-Credential
$s = New-PSSession -ConfigurationName Microsoft.exchange -ConnectionUri https://outlook.office365.com/Powershell-liveid/ -Credential $c -Authentication Basic -AllowRedirection
Import-PSSession $s

$mailbox = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails "UserMailbox" | Select-Object UserPrincipalName
Write-Warning "Please be patient ! It will take some to generate report."

$result = @()

Foreach ($m in $mailbox){
    Write-Host ("Getting size of mailbox : " + $m.UserPrincipalName) -fore Yellow
    $size = Get-MailboxStatistics -Identity $($m.UserPrincipalName) | Select-Object TotalItemSize

    $hash = [Ordered]@{
        UPN = $m.UserPrincipalName
        Mailboxsize = $size.TotalItemSize
    }
    $result += New-Object Psobject -property $hash
          
}
$result | Export-Csv -Path D:\Mailboxsize.csv -NoTypeInformation
Write-Output "Script has completed successfully."
