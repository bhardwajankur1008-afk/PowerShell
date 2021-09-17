
function Export-AllGroup
{
    Begin
    {
        $outputDistributionGroup = @()
        $outputSecurityGroup = @()
        $outputMailEnabledGroup = @()
        $outputMicrosoft365group = @()
        New-Item -Path D:\ExportedData -ItemType Directory -Force | Out-Null
    }

    Process
    {
        # Exporting Distribution groups, members and owners
        $distribution = Get-DistributionGroup -ResultSize Unlimited | select WindowsEmailAddress
        Write-Output "---------------------------------------------------------"
        Write-Host "Processing distribution groups.....".ToUpper() -Fore Yellow

        foreach ($d in $distribution) {
          
            Write-Host "$($d.WindowsEmailAddress)" -f Green
            $distributionMember = Get-DistributionGroupMember -Identity $($d.WindowsEmailAddress) | select Name
            $owner = Get-DistributionGroup -Identity $($d.WindowsEmailAddress) | select -ExpandProperty ManagedBy
            $property = [ordered]@{
                              
                "Distribution group" = $($d.WindowsEmailAddress)
                "Owners" = ($owner | Out-String).Trim()
                "Members" = ($distributionMember.Name | Out-String).Trim()      
            }
            $outputDistributionGroup += New-Object psobject -Property $property
            $outputDistributionGroup | Export-Csv -Path "D:\ExportedData\distribution.csv" -NoTypeInformation
        }

        # Exporting mail enabled security groups, members and owners
        Write-Output "---------------------------------------------------------"
        Write-Host "Processing mail enabled security groups.....".ToUpper() -fore Yellow
        $mailsecurity = Get-DistributionGroup -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'MailUniversalSecurityGroup'" | select PrimarySmtpAddress

        foreach ($m in $mailsecurity) {

            Write-Host "$($m.PrimarySmtpAddress)" -f White
            $mailSecurityMember = Get-DistributionGroupMember -Identity $($m.PrimarySmtpAddress) | select Name
            $owner = Get-DistributionGroup -Identity $($m.PrimarySmtpAddress) | select -ExpandProperty ManagedBy
            $property = [ordered]@{
    
                "Mail enabled security group" = $($m.PrimarySmtpAddress)
                "Owners" = ($owner | Out-String).Trim()
                "Members" = ($mailSecurityMember.Name | Out-String).Trim()
            }
            $outputMailEnabledGroup += New-Object psobject -Property $property
            $outputMailEnabledGroup | Export-Csv -Path "D:\ExportedData\mailEnabled.csv" -NoTypeInformation
        }

        # Exporting Microsoft 365 groups, members and owners
        Write-Output "---------------------------------------------------------"
        Write-Host "Processing Microsoft 365 groups.....".ToUpper() -fore Yellow
        $microsoft365group = Get-UnifiedGroup -ResultSize unlimited | select PrimarySmtpAddress

        foreach ($g in $microsoft365group) {

            Write-Host "$($g.PrimarySmtpAddress)" -f Magenta
            $microsoft365Member = Get-UnifiedGroupLinks -Identity $($g.PrimarySmtpAddress) -LinkType members | select Name
            $owner = Get-UnifiedGroup -Identity $($g.PrimarySmtpAddress) | select -ExpandProperty ManagedBy
            $property = [ordered]@{
    
                "Microsoft 365 group" = $($g.PrimarySmtpAddress)
                "Owners" = ($owner | Out-String).Trim()
                "Members" = ($microsoft365Member.Name | Out-String).Trim()
            }
            $outputMicrosoft365group += New-Object psobject -Property $property
            $outputMicrosoft365group | Export-Csv -Path "D:\ExportedData\Microsoft365Group.csv" -NoTypeInformation
        }

        # Exporting security groups, owners and members
        Write-Output "---------------------------------------------------------"
        Write-Host "Processing security groups.....".ToUpper() -fore Yellow
        $security = Get-MsolGroup -All | where {$_.GroupType -eq "Security"} | select DisplayName, ObjectId
        foreach ($s in $security) {

            Write-Host "$($s.DisplayName)" -f Cyan
            $securityMember = Get-MsolGroupMember -GroupObjectId $($s.ObjectId) | select EmailAddress
            $owner = Get-AzureADGroupOwner -ObjectId $($s.ObjectId) | select UserPrincipalName
            $property = [ordered]@{
    
                "Security group" = $($s.DisplayName)
                "Owners" = ($owner.UserPrincipalName | Out-String).Trim()
                "Members" = ($securityMember.EmailAddress | Out-String).Trim()
            }
            $outputSecurityGroup += New-Object psobject -Property $property
            $outputSecurityGroup | Export-Csv -Path "D:\ExportedData\securityGroup.csv" -NoTypeInformation
        }
    } 
}

Export-AllGroup