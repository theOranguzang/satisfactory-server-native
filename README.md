# Satisfactory Dedicated Server (Native Windows)

Native Windows installation of Satisfactory Dedicated Server with proper timeout configuration to fix connection issues.

## Key Features

- ✅ **Connection Fix**: Configured timeout settings to resolve "stuck on connecting" issue
- ✅ **Native Performance**: No Docker overhead
- ✅ **Easy Management**: PowerShell scripts for server control and monitoring
- ✅ **Complete Documentation**: See `chat-history` for detailed setup process

## Quick Start

### 1. Install SteamCMD

Download and extract SteamCMD to `steamcmd/` directory.

### 2. Download Satisfactory Server

```powershell
.\steamcmd\steamcmd.exe +login anonymous +app_update 1690800 validate +quit
```

### 3. Apply Configuration Template

Copy `Engine.ini.template` to `server/FactoryGame/Saved/Config/WindowsServer/Engine.ini`

This step is **CRITICAL** - it contains the timeout settings that fix the connection handshake issue.

### 4. Start Server

```powershell
.\start-server.ps1
```

### 5. Monitor Logs

```powershell
# View last 50 lines
.\check-logs.ps1

# Follow in real-time
.\check-logs.ps1 -Follow
```

## Server Information

- **Default Port**: 7777 (TCP/UDP)
- **Query Port**: 15000 (UDP)
- **Beacon Port**: 15777 (UDP)
- **Messaging Port**: 8888 (TCP)

Edit [start-server.ps1](start-server.ps1) to customize ports and settings.

## Configuration Files

- **Engine settings**: `server/FactoryGame/Saved/Config/WindowsServer/Engine.ini`
- **Game settings**: `server/FactoryGame/Saved/Config/WindowsServer/GameUserSettings.ini`
- **Server settings**: `server/FactoryGame/Saved/Server/ServerSettings.ini`
- **Save files**: `server/FactoryGame/Saved/SaveGames/`

## Firewall Configuration

Open these ports in Windows Firewall (run in **Administrator PowerShell**):

```powershell
New-NetFirewallRule -DisplayName "Satisfactory Server TCP" -Direction Inbound -LocalPort 7777 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Satisfactory Server UDP" -Direction Inbound -LocalPort 7777 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Satisfactory Query" -Direction Inbound -LocalPort 15000 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Satisfactory Beacon" -Direction Inbound -LocalPort 15777 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Satisfactory Messaging" -Direction Inbound -LocalPort 8888 -Protocol TCP -Action Allow
```

**Note:** Port 8888 (messaging port) is required for the ReliableMessaging system used for game state synchronization.

## The Connection Timeout Fix

The most critical configuration is in `Engine.ini.template`. The default Unreal Engine timeout values are too short for Satisfactory's initial connection handshake, causing clients to get stuck on "connecting to server."

**Solution**: Increase `InitialConnectTimeout` to 300 seconds (5 minutes) in all network driver sections.

### Known Limitation: WAN ReliableMessaging Timeout

⚠️ **IMPORTANT**: While the `InitialConnectTimeout` fix works for the initial connection phase, there is a **hardcoded 20-second timeout** in Satisfactory's ReliableMessaging system that affects WAN (internet) connections.

**Status:**
- ✅ **LAN connections**: Work perfectly
- ❌ **WAN connections**: Timeout after ~20 seconds during ReliableMessaging handshake
- 🐛 **Bug report**: [Open for 2+ years](https://questions.satisfactorygame.com/post/64b0e0f6ca608e080354c794), no developer fix

**What was tested:**
- All `.ini` configuration options
- Port 8888 (ReliableMessaging port)
- Multiple `multihome` parameter variations
- IPv6 disable/enable configurations
- WiFi vs Ethernet (minimal improvement)

**Root cause:** The ReliableMessaging handshake requires ~60 protocol exchanges. With WAN latency of 100ms+ per exchange, the total time (20-27 seconds) exceeds the hardcoded 20-second timeout.

**Workarounds:**
1. Use for LAN gaming only
2. Rent VPS/dedicated server hosting (lower latency)
3. Use client hosting instead of dedicated server

See [chat-history](chat-history) for the complete troubleshooting journey and technical details.

## Why Native Instead of Docker?

Initially tried Docker but encountered configuration persistence issues - the Engine.ini timeout settings kept reverting to defaults on container restart. Native installation allows configuration changes to persist properly.

## Connecting

- **LAN**: `<server-ip>:7777`
- **WAN**: `<public-ip>:7777` (requires port forwarding)

## Documentation

See [chat-history](chat-history) for:
- Complete setup process
- Troubleshooting steps taken
- Technical analysis of connection issues
- All commands and configurations used

## Migration from Docker

If migrating from a Docker setup, use [migrate-config.ps1](migrate-config.ps1) to copy save files and configurations.
