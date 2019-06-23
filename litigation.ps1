$c = Get-Credential
$s = New-PSSession -ConfigurationName Microsoft.exchange -ConnectionUri https://outlook.office365.com/Powershell-liveid/ -Credential $c -Authentication Basic -AllowRedirection
Import-PSSession $s -DisableNameChecking -AllowClobber

function Get-DiskInfo {
    [cmdletBinding()]
    param (
        [string]$Computer = "localhost",
        [string]$Drive = "C:"
    )

    Get-WmiObject -Class Win32_LogicalDisk -ComputerName $Computer -Filter "DeviceID='$Drive'" | `
        Select-Object DeviceID,
            @{l="FreeSpace(GB)"; e={$_.FreeSpace / 1GB -as [int]}},
            @{l="Size(GB)";e={$_.Size / 1GB -as [int]}}
}