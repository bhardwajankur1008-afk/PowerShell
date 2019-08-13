function Remove-UserFromGroup {
    [CmdletBinding()]
    Param
    (
        
        [Parameter(Mandatory = $true,
            Position = 0)]
        $path
    )

    Begin {
        $csv = Import-Csv D:\upn.csv
        $counter = 1
    }
    Process {
        Foreach ($c in $csv) {
            $dg = Get-DistributionGroup | where { (Get-DistributionGroupMember $_.PrimarySmtpAddress | Foreach { $_.name }) -contains $user.Alias } | select -ExpandProperty PrimarySmtpAddress
            $office = Get-UnifiedGroup | where { (Get-UnifiedGroupLinks $_.Alias -LinkType Members | foreach { $_.name }) -contains $user.Alias } | select -ExpandProperty PrimarySmtpAddress

            foreach ($d in $dg) {
                Write-Host "Removing $($c.UPN) from $($d)" -fore Yellow
                Remove-DistributionGroupMember -Identity $($d) -Member $($c.UPN) -Confirm:$false
            }

            foreach ($of in $office) {
                Write-Host "Removing $($c.UPN) from $($of)" -fore Cyan
                Remove-UnifiedGroupLinks -Identity $($of) -LinkType Members -Links $($c.UPN) -Confirm:$false 
            }
        }
  
    }
    End {
    }
}