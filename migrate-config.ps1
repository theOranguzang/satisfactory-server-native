# Migrate configuration from Docker to native Windows server

Write-Host "Migrating configuration from Docker setup..." -ForegroundColor Green

# Source paths (Docker volumes)
$DockerSavePath = "E:\satisfactory-server\saved\ServerSettings.7777.sav"
$DockerConfigPath = "E:\satisfactory-server\config\gamefiles\FactoryGame\Saved\Config\LinuxServer"

# Destination paths (Native Windows)
$NativeServerPath = "E:\satisfactory-server-native\server\FactoryGame\Saved"
$NativeConfigPath = "$NativeServerPath\Config\WindowsServer"
$NativeSavePath = "$NativeServerPath\Server"

# Create directories if they don't exist
Write-Host "Creating directories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $NativeConfigPath -Force | Out-Null
New-Item -ItemType Directory -Path $NativeSavePath -Force | Out-Null

# Copy save file
if (Test-Path $DockerSavePath) {
    Write-Host "Copying save file..." -ForegroundColor Cyan
    Copy-Item $DockerSavePath -Destination "$NativeSavePath\ServerSettings.ini" -Force
    Write-Host "  ✓ Save file copied" -ForegroundColor Green
} else {
    Write-Host "  ⚠ No save file found to migrate" -ForegroundColor Yellow
}

# Copy Engine.ini if it exists
$DockerEngineIni = "$DockerConfigPath\Engine.ini"
if (Test-Path $DockerEngineIni) {
    Write-Host "Copying Engine.ini..." -ForegroundColor Cyan
    Copy-Item $DockerEngineIni -Destination "$NativeConfigPath\Engine.ini" -Force
    Write-Host "  ✓ Engine.ini copied" -ForegroundColor Green
}

# Copy GameUserSettings.ini if it exists
$DockerGameSettings = "$DockerConfigPath\GameUserSettings.ini"
if (Test-Path $DockerGameSettings) {
    Write-Host "Copying GameUserSettings.ini..." -ForegroundColor Cyan
    Copy-Item $DockerGameSettings -Destination "$NativeConfigPath\GameUserSettings.ini" -Force
    Write-Host "  ✓ GameUserSettings.ini copied" -ForegroundColor Green
}

Write-Host "`nMigration complete!" -ForegroundColor Green
Write-Host "Native server configuration is ready." -ForegroundColor Cyan
