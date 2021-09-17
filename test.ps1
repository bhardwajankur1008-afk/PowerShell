function ConnectTo-AllService
{
    #read-host -assecurestring | convertfrom-securestring | out-file C:\mysecurestring.txt
    $username = "b.ankur@wicdata.site"
    $password = Get-Content 'C:\New_folder\secure.txt' | ConvertTo-SecureString
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

    Connect-ExchangeOnline -Credential $cred
    Connect-MsolService -Credential $cred
    Connect-PnPOnline -Url "https://zariii-admin.sharepoint.com/" -Credentials $cred
    Connect-AzureAD -Credential $cred
}
ConnectTo-AllService
