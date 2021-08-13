Add-Type -AssemblyName  System.Windows.Forms 

function NotifyUserToRest
{
    param (
        $message
    )

    $path = (Get-Process -id $pid).Path

    $global:balloon = New-Object System.Windows.Forms.NotifyIcon

    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info 
    $balloon.BalloonTipText = $message
    $balloon.BalloonTipTitle = "SimpleScreenRestReminder" 
    $balloon.Visible = $true 

    $balloon.ShowBalloonTip(5000)
}

Write-Output "Start the eye rest reminder, following the 20-20-20 rule."

$baseTime = 20

while ($true)
{
    # 20 minutes d'écran 
    Start-Sleep -s ($baseTime * 60)
    NotifyUserToRest -message "It's time to watch the world beyond 20 meters."

    # 20 secondes de repos 
    Start-Sleep -s ($baseTime * 1)
    NotifyUserToRest -message "Let's back to work !"
}