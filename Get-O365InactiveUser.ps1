function Get-O365InactiveUser
{
   Param
   (
        [Parameter(Mandatory=$true)]
        [ValidateSet("30", "60", "90")]
        [Alias("d")]
        [int]$Days
   )
   Begin
   {
        $output = @()
        $date = (Get-Date)
        $users = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -eq "UserMailbox"} | select UserPrincipalName
        Write-Host "Gathering data.....!" -f Cyan
   }
   Process
   {
        foreach ($u in $users) {
            $logonDetail = Get-MailboxStatistics -Identity $($u.UserPrincipalName) | select LastLogonTime
            $difranceValue = New-TimeSpan -End $date -Start $logonDetail.LastLogonTime | select Days

            if ($Days -le $difranceValue.Days) {
                Write-Host "Processing user:" $($u.UserPrincipalName) -f Green

                $property = [Ordered]@{
                    "User Principal Name" = $($u.UserPrincipalName)
                    "Last logon date"     = $logonDetail.LastLogonTime
                }
                $output += New-Object psobject -Property $property                  
            }
        }
        $output | Export-Csv d:\logonDetails.csv -NoTypeInformation
   }
}
