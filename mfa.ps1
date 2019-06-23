<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    U
.DESCRIPTION
    Office 365 MFA mini tool 
#>
#Connect-MsolService

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '383,145'
$Form.text                       = "O365 MFA mini tool ver 1.0"
$Form.BackColor                  = "#50e3c2"
$Form.TopMost                    = $false
$form.Opacity                    = 50

$user_label                      = New-Object system.Windows.Forms.Label
$user_label.text                 = "UserPrincipalName"
$user_label.AutoSize             = $true
$user_label.width                = 25
$user_label.height               = 10
$user_label.location             = New-Object System.Drawing.Point(10,21)
$user_label.Font                 = 'Microsoft Sans Serif,10'

$user_textbox                    = New-Object system.Windows.Forms.TextBox
$user_textbox.multiline          = $false
$user_textbox.text               = "tom@totalnoob.tk"
$user_textbox.width              = 234
$user_textbox.height             = 20
$user_textbox.location           = New-Object System.Drawing.Point(142,21)
$user_textbox.Font               = 'Microsoft Sans Serif,10'

$enable_button                   = New-Object system.Windows.Forms.Button
$enable_button.BackColor         = "#7ed321"
$enable_button.text              = "Enable"
$enable_button.width             = 73
$enable_button.height            = 30
$enable_button.location          = New-Object System.Drawing.Point(10,79)
$enable_button.Font              = 'Microsoft Sans Serif,10'
$enable_button.ForeColor         = ""

$enforce_button                  = New-Object system.Windows.Forms.Button
$enforce_button.BackColor        = "#417505"
$enforce_button.text             = "Enforce"
$enforce_button.width            = 86
$enforce_button.height           = 30
$enforce_button.location         = New-Object System.Drawing.Point(152,80)
$enforce_button.Font             = 'Microsoft Sans Serif,10'

$disable_button                  = New-Object system.Windows.Forms.Button
$disable_button.BackColor        = "#d0021b"
$disable_button.text             = "Disable"
$disable_button.width            = 72
$disable_button.height           = 30
$disable_button.location         = New-Object System.Drawing.Point(304,80)
$disable_button.Font             = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($user_label,$user_textbox,$enable_button,$enforce_button,$disable_button))

# $user_textbox = 

function set-actionOnClick {
    param ($user_textbox = ($user_textbox | Select-Object Text))
}

$enable_button.Add_Click(
    {
        set-actionOnClick
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement 
        $st.RelyingParty = "*" 
        $st.State = "Enabled" 
        $sta = @($st) 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta
    }
)

$disable_button.Add_Click(
    {
        $sta = @() 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta
    }
)

$enforce_button.Add_Click(
    {
        $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement 
        $st.RelyingParty = "*" 
        $st.State = "Enforced" 
        $sta = @($st) 
        Set-MsolUser -UserPrincipalName $user_textbox.Text -StrongAuthenticationRequirements $sta

    }
)

$form.ShowDialog()

#$enable_button | gm