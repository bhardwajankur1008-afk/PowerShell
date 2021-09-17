Write-Host "Please wait while script is running....." -f Cyan
Write-Host ""
$mailbox = Get-Mailbox -ResultSize Unlimited | where {($_.ForwardingSmtpAddress -ne $null) -or ($_.ForwardingAddress -ne $null)} | select UserPrincipalName,ForwardingAddress, ForwardingSmtpAddress, RecipientTypeDetails
$result = @()
Write-Host "Total forwarding enabled users:"$mailbox.count -F Yellow

foreach ($m in $mailbox) {
    $country = Get-User -Identity $m.UserPrincipalName | Select CountryOrRegion, city
    $property = [ordered]@{
        "User" = $($m.UserPrincipalName)
        "Mailbox type" = $m.RecipientTypeDetails
        "Country" = $country.CountryOrRegion
        "City" = $country.city
        "ForwardingAddress" = $m.ForwardingAddress
        "ForwardingSmtpAddress" = $m.ForwardingSmtpAddress
        
    }
    $result += New-Object psobject -Property $property
}
$result | Export-Csv d:\fowardingData.csv -NoTypeInformation
Write-Host ""
Write-Host "A file with name 'forwardingData.csv' has been generated in D drive." -F Green