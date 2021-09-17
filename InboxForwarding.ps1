
$users = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -eq "UserMailbox"}
$output = @()

foreach ($u in $users) {
    $inboxRule = Get-InboxRule -Mailbox $u.UserPrincipalName | select Name, RuleIdentity, Enabled, ForwardTo, ForwardAsAttachmentTo

    foreach ($i in $inboxRule) {

        if (!($i.ForwardTo -or $i.ForwardAsAttachmentTo)){}

        else
        {
            $property = [ordered]@{
                Mailbox = $($u.UserPrincipalName)
                RuleName = $($i.Name)
                RuleId = $($i.RuleIdentity)
                ForwardTo = $($i.ForwardTo)
                ForwardAsAttachmentTo = $($i.ForwardAsAttachmentTo)
            }
            Write-Host ""
            Write-Host "Forwarding rule found!" -f DarkMagenta -b White
            Write-Host ""
            Write-Output $property
            Write-Host "-----------------------------------------" -f white
        }
        $output += New-Object psobject -Property $property 
    }
}
Write-Host "Exporting results in CSV file, Please wait!......" -f Cyan
$output | Export-Csv .\temp\output.csv -NoTypeInformation
Write-Host "Done exporting! Find 'output.csv' in C:\temp directory." -f Yellow