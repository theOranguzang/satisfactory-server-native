# Satisfactory Server Log Viewer
# Usage: .\check-logs.ps1 [-Lines 50] [-Follow]

param(
    [int]$Lines = 50,
    [switch]$Follow
)

$LogPath = "E:\satisfactory-server-native\server\FactoryGame\Saved\Logs\FactoryGame.log"

if ($Follow) {
    Write-Host "Following log file (Ctrl+C to stop)..." -ForegroundColor Cyan
    Get-Content $LogPath -Tail $Lines -Wait
} else {
    Write-Host "Last $Lines lines from server log:" -ForegroundColor Cyan
    Get-Content $LogPath -Tail $Lines
}
