# Satisfactory Dedicated Server Startup Script
# Server: nokevins
# Port: 7777

$ServerPath = "E:\satisfactory-server-native\server"
$ServerExe = "$ServerPath\FactoryServer.exe"

# Server parameters
$ServerParams = @(
    "-Port=7777",
    "-ServerQueryPort=15000",
    "-BeaconPort=15777",
    "-log",
    "-unattended"
)

Write-Host "Starting Satisfactory Dedicated Server..." -ForegroundColor Green
Write-Host "Server Path: $ServerPath" -ForegroundColor Cyan
Write-Host "Parameters: $($ServerParams -join ' ')" -ForegroundColor Cyan

# Start the server
& $ServerExe $ServerParams
