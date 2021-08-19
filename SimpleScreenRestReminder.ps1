Add-Type -AssemblyName  System.Windows.Forms 

#TODO : 
# - Find a way to restart the script after sleep mode

function NotifyUserToRest
{
    param (
        $message
    )

    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $notificationTime = 5000

    $path = (Get-Process -id $pid).Path

    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info 
    $balloon.BalloonTipText = $message
    $balloon.BalloonTipTitle = "SimpleScreenRestReminder" 
    $balloon.Visible = $true 

    $balloon.ShowBalloonTip($notificationTime)

    Start-Sleep -Milliseconds $notificationTime # Wait for the notification period
    $balloon.Dispose() # Dispose of the notification in order to not stack it in the Windows tray
}

Write-Output "Start the eye rest reminder, following the 20-20-20 rule."

$baseTime = 20

while ($true)
{
    # 20 minutes of screen time
    Start-Sleep -s ($baseTime * 60)
    Write-Output "It's time to watch the world beyond 20 meters."
    NotifyUserToRest -message "It's time to watch the world beyond 20 meters."

    # 20 seconds of eye rest
    Start-Sleep -s ($baseTime * 1)
    Write-Output "Let's back to work !"
    NotifyUserToRest -message "Let's back to work !"
}