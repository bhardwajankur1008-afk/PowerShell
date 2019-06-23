<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object system.Windows.Forms.Form
$form.ClientSize = '302,437'
$form.text = "MFA mini tool 2.0"
$form.BackColor = "#bd10e0"
$form.TopMost = $false
$form.MaximizeBox = $false
$form.FormBorderStyle = 'FixedSingle'

$login_groupbox = New-Object system.Windows.Forms.Groupbox
$login_groupbox.height = 150
$login_groupbox.width = 291
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
$admin_textbox.width = 185
$admin_textbox.height = 20
$admin_textbox.location = New-Object System.Drawing.Point(97, 24)
$admin_textbox.Font = 'Microsoft Sans Serif,10'

$pwd_textbox = New-Object system.Windows.Forms.TextBox
$pwd_textbox.multiline = $false
$pwd_textbox.PasswordChar = '*'
$pwd_textbox.width = 185
$pwd_textbox.height = 20
$pwd_textbox.location = New-Object System.Drawing.Point(97, 64)
$pwd_textbox.Font = 'Microsoft Sans Serif,10'

$login_button = New-Object system.Windows.Forms.Button
$login_button.BackColor = "#f8e71c"
$login_button.text = "Login"
$login_button.width = 70
$login_button.height = 25
$login_button.location = New-Object System.Drawing.Point(9, 110)
$login_button.Font = 'Microsoft Sans Serif,10'

$about_button = New-Object system.Windows.Forms.Button
$about_button.BackColor = "#f8e71c"
$about_button.text = "About"
$about_button.width = 70
$about_button.height = 25
$about_button.location = New-Object System.Drawing.Point(215, 110)
$about_button.Font = 'Microsoft Sans Serif,10'

$mfa_groupbox = New-Object system.Windows.Forms.Groupbox
$mfa_groupbox.height = 150
$mfa_groupbox.width = 291
$mfa_groupbox.text = "MFA"
$mfa_groupbox.location = New-Object System.Drawing.Point(5, 172)

$user_textbox = New-Object system.Windows.Forms.TextBox
$user_textbox.multiline = $false
$user_textbox.text = "Type upn and click on search"
$user_textbox.width = 198
$user_textbox.height = 20
$user_textbox.location = New-Object System.Drawing.Point(7, 25)
$user_textbox.Font = 'Microsoft Sans Serif,10'

$find_button = New-Object system.Windows.Forms.Button
$find_button.BackColor = "#f8e71c"
$find_button.text = "Find"
$find_button.width = 70
$find_button.height = 25
$find_button.location = New-Object System.Drawing.Point(218, 25)
$find_button.Font = 'Microsoft Sans Serif,10'

$login_label = New-Object system.Windows.Forms.Label
$login_label.AutoSize = $false
$login_label.enabled = $true
$login_label.width = 118
$login_label.height = 18
$login_label.location = New-Object System.Drawing.Point(97, 115)
$login_label.Font = 'Microsoft Sans Serif,10'

$info_textbox = New-Object system.Windows.Forms.TextBox
$info_textbox.multiline = $true
$info_textbox.text = "MFA STATUS"
$info_textbox.width = 198
$info_textbox.height = 20
$info_textbox.location = New-Object System.Drawing.Point(6, 62)
$info_textbox.Font = 'Microsoft Sans Serif,10,style=Bold'

$status_label = New-Object system.Windows.Forms.Label
$status_label.AutoSize = $false
$status_label.width = 79
$status_label.height = 13
$status_label.location = New-Object System.Drawing.Point(106, 115)
$status_label.Font = 'Microsoft Sans Serif,10,style=Italic'

$enable_radio = New-Object system.Windows.Forms.RadioButton
$enable_radio.text = "Enable"
$enable_radio.AutoSize = $true
$enable_radio.width = 104
$enable_radio.height = 20
$enable_radio.location = New-Object System.Drawing.Point(4, 118)
$enable_radio.Font = 'Microsoft Sans Serif,10'

$enforce_radio = New-Object system.Windows.Forms.RadioButton
$enforce_radio.text = "Enforce"
$enforce_radio.AutoSize = $true
$enforce_radio.width = 104
$enforce_radio.height = 20
$enforce_radio.location = New-Object System.Drawing.Point(108, 118)
$enforce_radio.Font = 'Microsoft Sans Serif,10'

$disable_radio = New-Object system.Windows.Forms.RadioButton
$disable_radio.text = "Disable"
$disable_radio.AutoSize = $true
$disable_radio.width = 104
$disable_radio.height = 20
$disable_radio.location = New-Object System.Drawing.Point(206, 118)
$disable_radio.Font = 'Microsoft Sans Serif,10'

$update_groupbox = New-Object system.Windows.Forms.Groupbox
$update_groupbox.height = 102
$update_groupbox.width = 291
$update_groupbox.text = "Update"
$update_groupbox.location = New-Object System.Drawing.Point(6, 328)

$update_button = New-Object system.Windows.Forms.Button
$update_button.BackColor = "#f8e71c"
$update_button.text = "UPDATE"
$update_button.width = 88
$update_button.height = 40
$update_button.location = New-Object System.Drawing.Point(95, 30)
$update_button.Font = 'Microsoft Sans Serif,10'

$form.controls.AddRange(@($login_groupbox, $mfa_groupbox, $update_groupbox))
$login_groupbox.controls.AddRange(@($admin_label, $pwd_label, $admin_textbox, $pwd_textbox, $login_button, $about_button, $login_label, $status_label))
$mfa_groupbox.controls.AddRange(@($user_textbox, $find_button, $info_textbox, $enable_radio, $enforce_radio, $disable_radio))
$update_groupbox.controls.AddRange(@($update_button))

$login_button.Add_Click( { 
        if (Get-Login -match "Authentication Error") {
            $login_label.text = "Login Failed"
        }
        else {
            $login_label.Text = "Login Successful"
        }
    })

$about_button.Add_Click( {
        show-messagebox
    })

$find_button.Add_Click( { 
        get-userfromFind
    })

$update_button.Add_Click( {
        update-mfaStatus
    })

$enable_radio.Add_Click( {
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement 
        $st.RelyingParty = "*" 
        $st.State = "Enabled" 
        $sta = @($st) 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta
    })

$enforce_radio.Add_Click( { 
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement 
        $st.RelyingParty = "*" 
        $st.State = "Enforced" 
        $sta = @($st) 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta
    })

$disable_radio.Add_Click( {
        $sta = @() 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta
    })

# functions
function get-login {
    $pass = ConvertTo-SecureString -String ($pwd_textbox.Text) -AsPlainText -Force
    $c = New-Object -TypeName system.management.automation.pscredential -ArgumentList $admin_textbox.Text, $pass
    Connect-MsolService -Credential $c
}

function show-messagebox {
    [system.Windows.forms.messagebox]::Show("Thanks for using this application ! Created by Ankur in his free time you can reach him at his email address 'a001bhardwaj@gmail.com'", "About")   
}

function get-userFromFind {
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

function update-mfaStatus {
    $user_textbox.Text
}

[void]$form.ShowDialog()