<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    export
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$groupExport = New-Object system.Windows.Forms.Form
$groupExport.ClientSize = '360,459'
$groupExport.text = "Easy group exporter"
$groupExport.BackColor = "#ffffff"
$groupExport.TopMost = $false
$groupExport.MaximizeBox = $false
$groupExport.FormBorderStyle = "FixedSingle"

$txtboxAdmin = New-Object system.Windows.Forms.MaskedTextBox
$txtboxAdmin.multiline = $false
$txtboxAdmin.width = 191
$txtboxAdmin.height = 20
$txtboxAdmin.location = New-Object System.Drawing.Point(135, 18)
$txtboxAdmin.Font = 'Microsoft Sans Serif,10'

$txtboxPwd = New-Object system.Windows.Forms.MaskedTextBox
$txtboxPwd.multiline = $false
$txtboxPwd.width = 191
$txtboxPwd.height = 20
$txtboxPwd.location = New-Object System.Drawing.Point(135, 71)
$txtboxPwd.Font = 'Microsoft Sans Serif,10'
$txtboxPwd.PasswordChar = "*"

$loginGroupBox = New-Object system.Windows.Forms.Groupbox
$loginGroupBox.height = 169
$loginGroupBox.width = 347
$loginGroupBox.text = "Login"
$loginGroupBox.location = New-Object System.Drawing.Point(6, 5)

$exportGroupbox = New-Object system.Windows.Forms.Groupbox
$exportGroupbox.height = 268
$exportGroupbox.width = 347
$exportGroupbox.text = "Export groups"
$exportGroupbox.location = New-Object System.Drawing.Point(6, 183)

$labelAdmin = New-Object system.Windows.Forms.Label
$labelAdmin.text = "Admin"
$labelAdmin.AutoSize = $true
$labelAdmin.width = 25
$labelAdmin.height = 10
$labelAdmin.location = New-Object System.Drawing.Point(9, 23)
$labelAdmin.Font = 'Microsoft Sans Serif,10'
$labelAdmin.ForeColor = "#000000"

$labelPwd = New-Object system.Windows.Forms.Label
$labelPwd.text = "Password"
$labelPwd.AutoSize = $true
$labelPwd.width = 25
$labelPwd.height = 10
$labelPwd.location = New-Object System.Drawing.Point(9, 73)
$labelPwd.Font = 'Microsoft Sans Serif,10'
$labelPwd.ForeColor = "#000000"

$loginBtn = New-Object system.Windows.Forms.Button
$loginBtn.text = "Login"
$loginBtn.width = 60
$loginBtn.height = 30
$loginBtn.location = New-Object System.Drawing.Point(9, 120)
$loginBtn.Font = 'Microsoft Sans Serif,10'
$loginBtn.ForeColor = ""

$aboutBtn = New-Object system.Windows.Forms.Button
$aboutBtn.text = "About"
$aboutBtn.width = 60
$aboutBtn.height = 30
$aboutBtn.location = New-Object System.Drawing.Point(278, 119)
$aboutBtn.Font = 'Microsoft Sans Serif,10'

$dlChkbox = New-Object system.Windows.Forms.CheckBox
$dlChkbox.text = "DG"
$dlChkbox.AutoSize = $false
$dlChkbox.width = 47
$dlChkbox.height = 20
$dlChkbox.location = New-Object System.Drawing.Point(9, 27)
$dlChkbox.Font = 'Microsoft Sans Serif,10'

$securityChkbox = New-Object system.Windows.Forms.CheckBox
$securityChkbox.text = "Security"
$securityChkbox.AutoSize = $false
$securityChkbox.width = 75
$securityChkbox.height = 20
$securityChkbox.location = New-Object System.Drawing.Point(142, 27)
$securityChkbox.Font = 'Microsoft Sans Serif,10'

$officeChkbox = New-Object system.Windows.Forms.CheckBox
$officeChkbox.text = "Office"
$officeChkbox.AutoSize = $false
$officeChkbox.width = 65
$officeChkbox.height = 20
$officeChkbox.location = New-Object System.Drawing.Point(276, 27)
$officeChkbox.Font = 'Microsoft Sans Serif,10'

$mailChkbox = New-Object system.Windows.Forms.CheckBox
$mailChkbox.text = "MEnabled"
$mailChkbox.AutoSize = $false
$mailChkbox.width = 80
$mailChkbox.height = 20
$mailChkbox.location = New-Object System.Drawing.Point(9, 67)
$mailChkbox.Font = 'Microsoft Sans Serif,10'

$syncedChkbox = New-Object system.Windows.Forms.CheckBox
$syncedChkbox.text = "Synced"
$syncedChkbox.AutoSize = $false
$syncedChkbox.width = 70
$syncedChkbox.height = 20
$syncedChkbox.location = New-Object System.Drawing.Point(142, 67)
$syncedChkbox.Font = 'Microsoft Sans Serif,10'

$ddgChkbox = New-Object system.Windows.Forms.CheckBox
$ddgChkbox.text = "DDG"
$ddgChkbox.AutoSize = $false
$ddgChkbox.width = 56
$ddgChkbox.height = 20
$ddgChkbox.location = New-Object System.Drawing.Point(276, 67)
$ddgChkbox.Font = 'Microsoft Sans Serif,10'

$exportBtn = New-Object system.Windows.Forms.Button
$exportBtn.text = "Export !"
$exportBtn.width = 119
$exportBtn.height = 47
$exportBtn.location = New-Object System.Drawing.Point(114, 214)
$exportBtn.Font = 'Microsoft Sans Serif,12,style=Bold,Italic'

$whrMskd = New-Object system.Windows.Forms.MaskedTextBox
$whrMskd.multiline = $false
$whrMskd.text = "Where to save files ???"
$whrMskd.width = 325
$whrMskd.height = 26
$whrMskd.location = New-Object System.Drawing.Point(7, 115)
$whrMskd.Font = 'Microsoft Sans Serif,10,style=Bold,Italic'
$whrMskd.ForeColor = "#000000"

$statusLbl                       = New-Object system.Windows.Forms.Label
$statusLbl.AutoSize              = $false
$statusLbl.width                 = 100
$statusLbl.height                = 19
$statusLbl.location              = New-Object System.Drawing.Point(119,173)
$statusLbl.Font                  = 'Microsoft Sans Serif,10,style=Bold'

$groupExport.controls.AddRange(@($loginGroupBox, $exportGroupbox))
$loginGroupBox.controls.AddRange(@($labelAdmin, $labelPwd, $loginBtn, $aboutBtn, $txtboxAdmin, $txtboxPwd))
$exportGroupbox.controls.AddRange(@($dlChkbox, $securityChkbox, $officeChkbox, $mailChkbox, $syncedChkbox, $ddgChkbox, $exportBtn, $whrMskd, $statusLbl))


<#
    Fuctions start from here
#>

function show-messagebox {
    [system.Windows.forms.messagebox]::show("Thanks for using this small application, i hope you like it. 
Created by 'Ankur' in his free time.", "About the author...")
}

function connect-o365 {
    # connecting to office 365 
    $password = ConvertTo-SecureString -String ($txtboxPwd.Text) -AsPlainText -Force
    $c = new-object -typename System.Management.Automation.PSCredential -argumentlist $txtboxAdmin.Text, $password
    $s = New-PSSession -ConfigurationName Microsoft.exchange -ConnectionUri https://outlook.office365.com/PowerShell/liveid -Credential $c -Authentication Basic -AllowRedirection
    Import-PSSession $s -DisableNameChecking -AllowClobber
    Connect-MsolService -Credential $c
    $statusLbl.text = "Connected!"
}

function export-data {
    # check the checkbox whether enabled or not
    [string]$whrMskd.Text = $whrMskd.Text
    $statusLbl.Text = "Generating files!"
    

    # export dl
    if ($dlChkbox.Checked -eq $true) {
        Get-DistributionGroup -ResultSize unlimited | Select-Object DisplayName, EmailAddresses | Export-Csv -Path ($whrMskd.Text + "distribution.csv") -NoTypeInformation
    }
    
    # export security group
    if ($securityChkbox.Checked -eq $true) {
        Get-MsolGroup -MaxResults 1000 | Where-Object { $_.GroupType -eq "Security" } | Select-Object DisplayName | Export-Csv -Path ($whrMskd.Text + "SecurityGroup.csv") -NoTypeInformation
    }

    # export office365 group
    if ($officeChkbox.Checked -eq $true) {
        Get-UnifiedGroup -ResultSize unlimited | Select-Object DisplayName, PrimarySmtpAddress | export-csv -Path ($whrMskd.Text + "Office365Group.csv") -NoTypeInformation
    }

    # export mailenabled group
    if ($mailChkbox.Checked -eq $true) {
        Get-MsolGroup -MaxResults 1000 | Where-Object { $_.LastDirSyncTime -ne "" -and $_.GroupType -eq "Security" } | Select-Object DisplayName | export-csv -Path ($whrMskd.Text + "SyncedSecurity.csv") -NoTypeInformation
    }

    # export DDG
    if ($ddgChkbox.Checked -eq $true) {
        Get-DynamicDistributionGroup -ResultSize unlimited | Select-Object DisplayName, EmailAddresses | Export-Csv -Path ($whrMskd.Text + "DDG.csv") -NoTypeInformation
    }

    $statusLbl = "Generated!"
}

<#
    Methods
 #>


$aboutBtn.Add_Click( {
        # event showing message box in screen
        show-messagebox
    })

$loginBtn.Add_Click( {
        # event to connect Office365
        connect-o365
    })

$exportBtn.Add_Click( {
        #export data in drive
        export-data
    })





[void]$groupExport.ShowDialog()
