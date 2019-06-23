<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object system.Windows.Forms.Form
$form.ClientSize = '322,481'
$form.text = "MFA mini tool 2.0"
$form.TopMost = $false
$form.MaximizeBox = $false
$form.FormBorderStyle = 'FixedSingle'

$login_groupbox = New-Object system.Windows.Forms.Groupbox
$login_groupbox.height = 216
$login_groupbox.width = 311
$login_groupbox.text = "Login"
$login_groupbox.location = New-Object System.Drawing.Point(6, 9)

$admin_label = New-Object system.Windows.Forms.Label
$admin_label.text = "Admin"
$admin_label.AutoSize = $true
$admin_label.width = 25
$admin_label.height = 10
$admin_label.location = New-Object System.Drawing.Point(9, 29)
$admin_label.Font = 'Microsoft Sans Serif,10'

$pwd_label = New-Object system.Windows.Forms.Label
$pwd_label.text = "Password"
$pwd_label.AutoSize = $true
$pwd_label.width = 25
$pwd_label.height = 10
$pwd_label.location = New-Object System.Drawing.Point(9, 71)
$pwd_label.Font = 'Microsoft Sans Serif,10'

$admin_textbox = New-Object system.Windows.Forms.TextBox
$admin_textbox.multiline = $false
$admin_textbox.width = 159
$admin_textbox.height = 20
$admin_textbox.location = New-Object System.Drawing.Point(97, 24)
$admin_textbox.Font = 'Microsoft Sans Serif,10'

$pwd_textbox = New-Object system.Windows.Forms.TextBox
$pwd_textbox.multiline = $false
$pwd_textbox.PasswordChar = '*'
$pwd_textbox.width = 159
$pwd_textbox.height = 20
$pwd_textbox.location = New-Object System.Drawing.Point(97, 64)
$pwd_textbox.Font = 'Microsoft Sans Serif,10'

$login_button = New-Object system.Windows.Forms.Button
$login_button.text = "Login"
$login_button.width = 70
$login_button.height = 25
$login_button.location = New-Object System.Drawing.Point(9, 110)
$login_button.Font = 'Microsoft Sans Serif,10'

$about_button = New-Object system.Windows.Forms.Button
$about_button.text = "About"
$about_button.width = 70
$about_button.height = 25
$about_button.location = New-Object System.Drawing.Point(231, 110)
$about_button.Font = 'Microsoft Sans Serif,10'

$mfa_groupbox = New-Object system.Windows.Forms.Groupbox
$mfa_groupbox.height = 224
$mfa_groupbox.width = 311
$mfa_groupbox.text = "MFA"
$mfa_groupbox.location = New-Object System.Drawing.Point(6, 247)

$user_textbox = New-Object system.Windows.Forms.TextBox
$user_textbox.multiline = $false
$user_textbox.text = "Type upn and click on search"
$user_textbox.width = 198
$user_textbox.height = 20
$user_textbox.location = New-Object System.Drawing.Point(7, 25)
$user_textbox.Font = 'Microsoft Sans Serif,10'

$search_button = New-Object system.Windows.Forms.Button
$search_button.text = "Search"
$search_button.width = 70
$search_button.height = 25
$search_button.location = New-Object System.Drawing.Point(230, 25)
$search_button.Font = 'Microsoft Sans Serif,10'

$login_label = New-Object system.Windows.Forms.Label
$login_label.text = "status"
$login_label.AutoSize = $false
$login_label.enabled = $true
$login_label.width = 169
$login_label.height = 18
$login_label.location = New-Object System.Drawing.Point(62, 167)
$login_label.Font = 'Microsoft Sans Serif,10'

$info_textbox = New-Object system.Windows.Forms.TextBox
$info_textbox.multiline = $true
$info_textbox.text = "information"
$info_textbox.width = 294
$info_textbox.height = 155
$info_textbox.location = New-Object System.Drawing.Point(6, 62)
$info_textbox.Font = 'Microsoft Sans Serif,10'

$form.controls.AddRange(@($login_groupbox, $mfa_groupbox))
$login_groupbox.controls.AddRange(@($admin_label, $pwd_label, $admin_textbox, $pwd_textbox, $login_button, $about_button, $login_label))
$mfa_groupbox.controls.AddRange(@($user_textbox, $search_button, $info_textbox))

function Get-Login {
    
    $pass = ConvertTo-SecureString -String ($pwd_textbox.Text) -AsPlainText -Force

    $c = New-Object -TypeName system.management.automation.pscredential -ArgumentList $admin_textbox.Text, $pass
    Connect-MsolService -Credential $c
}

function Get-UserFromSearch {

    $m = Get-MsolUser -UserPrincipalName $user_textbox.Text | Select-Object -ExpandProperty StrongAuthenticationRequirements | Select-Object state

    if ($m.State) {
        $info_textbox.Text = "Enabled"
    }
    else {
        $info_textbox.Text = "Disabled"
    }
    if ($m.State -eq "Enforced") {
        $info_textbox.Text = "Enforced"
    }
}

function show-messagebox {
    [system.Windows.forms.messagebox]::Show("Thanks for using this software !\nCreated by Ankur", "About")
    
}

$search_button.add_click(
    {
        Get-UserFromSearch 
    }
)

$login_button.Add_Click(
    {
        if (Get-Login -match "Authentication Error") {
            $login_label.text = "Login Failed !!!"
        }
        else {
            $login_label.Text = "Login Successful !!!"
        }
            
    }
)

$about_button.add_click(
    {
        show-messagebox
    }
)


[void]$form.ShowDialog()

