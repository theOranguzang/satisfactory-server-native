# Connecting to the Server

This guide shows how to connect to your Satisfactory dedicated server from the game client.

## From the Satisfactory Main Menu

### Step 1: Open Server Manager
1. Launch Satisfactory
2. Click **"Server Manager"** from the main menu

### Step 2: Add Server
1. Click **"Add Server"** button
2. Fill in the server details:

### Step 3: Server Details

**For LAN (Local Network) Connections:**
- **Server Name**: (any name you want, e.g., "My Server")
- **IP Address**: `74.137.165.140:7777`
  - Example: `192.168.4.50:7777`
- **Admin Password**: (enter if you need admin access)
- **Server Password**: (enter if server is password-protected)

**For WAN (Internet) Connections:**
- **Server Name**: (any name you want, e.g., "My Server")
- **IP Address**: `74.137.165.140:7777`
  - Example: `74.137.165.140:7777`
- **Admin Password**: (enter if you need admin access)
- **Server Password**: (enter if server is password-protected)

### Step 4: Connect
1. Click **"Confirm"** to save the server
2. Select your server from the list
3. Click **"Join Game"**

## Important Notes

### NAT Hairpinning Issue
- If you're on the **same LAN** as the server, you **must** use the **LAN IP address**
- Using the public/WAN IP from inside the same network will fail due to NAT hairpinning limitations
- Friends connecting from the internet should use your public/WAN IP address

### Firewall Requirements
Make sure these ports are open:
- **7777** (TCP/UDP) - Game port
- **15000** (UDP) - Query port
- **15777** (UDP) - Beacon port

### Port Forwarding
For internet connections, ensure port forwarding is configured on your router:
- Forward port **7777** (TCP/UDP) to your server's LAN IP
- Forward port **15000** (UDP) to your server's LAN IP
- Forward port **15777** (UDP) to your server's LAN IP

## Troubleshooting

### "Server Offline" or "Cannot Connect"
- Verify the server is running: `Get-Process -Name "FactoryServer"`
- Check firewall rules are active
- Confirm port forwarding is configured correctly
- LAN users: Use LAN IP, not WAN IP
- WAN users: Confirm your public IP hasn't changed

### "Connection Timeout" or "Connection Lost"
- Check if you're using the correct IP (LAN vs WAN)
- Verify all required ports are open
- Check server logs: `.\check-logs.ps1`

### First Connection Takes Long
- The initial connection may take 30-60 seconds to complete
- The server needs time to initialize the session
- Be patient and don't retry too quickly
