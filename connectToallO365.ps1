function ConnectTo-AllService
{
    $username = "b.ankur@wicdata.site"
    $password = Get-Content 'C:\New folder\secure.txt' | ConvertTo-SecureString
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

    Connect-ExchangeOnline -Credential $cred
    Connect-MsolService -Credential $cred
    Connect-PnPOnline -Url "https://zariii-admin.sharepoint.com/" -Credentials $cred
}
