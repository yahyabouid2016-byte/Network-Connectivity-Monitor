# Network Connectivity Monitor

> Automated background network monitoring script — pings a list of hosts and logs results with timestamps.

---

## What It Does

- Reads a list of hosts/IPs from `hosts.txt`
- Pings each target (2 ICMP packets)
- Logs **SUCCESS / FAILED** status with timestamps to `Network_Monitor_Log.txt`
- Runs silently in the background via **Task Scheduler**
- Opens the log automatically after each run

---

## Use Case

Designed for **LAN environments** to continuously monitor connectivity to key network devices (routers, servers, printers, etc.) without manual intervention.

---

## Requirements

- Windows OS
- PowerShell 5.1 or later
- Administrator rights (recommended for Task Scheduler setup)

---

## File Structure

```
network-monitor/
├── Monitor.ps1             # Main script
├── hosts.example.txt       # Example hosts file (rename to hosts.txt)
├── Network_Monitor_Log.txt # Auto-generated log (excluded from git)
└── README.md
```

---

## Setup

### 1. Clone the repo
```bash
git clone https://github.com/YOUR_USERNAME/network-monitor.git
cd network-monitor
```

### 2. Configure your hosts
```bash
copy hosts.example.txt hosts.txt
notepad hosts.txt
```
Add one IP or hostname per line. Lines starting with `#` are ignored.

### 3. Run manually
```powershell
.\Monitor.ps1
```

### 4. Schedule as background task (Task Scheduler)

To run automatically every X minutes:

1. Open **Task Scheduler** → Create Basic Task
2. Trigger: `On a schedule` (e.g., every 5 minutes)
3. Action: `Start a program`
   - Program: `powershell.exe`
   - Arguments: `-ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\path\to\Monitor.ps1"`
4. Check: `Run whether user is logged on or not`

---

## Log Format

```
--- Test started at: 2025-01-15 14:30:00 ---
2025-01-15 14:30:01 | Target: 192.168.1.1   | Connection successful (SUCCESS)
2025-01-15 14:30:02 | Target: 192.168.1.10  | Connection failed (FAILED)
--- Test finished. ---
```

---

## hosts.txt Format

See `hosts.example.txt` for reference:

```
# Routers / Gateways
192.168.1.1

# Servers
192.168.1.10

# External connectivity check
8.8.8.8
google.com
```

---

## Skills Demonstrated

- PowerShell scripting & automation
- Network diagnostics (ICMP / ping)
- File I/O & structured logging
- Windows Task Scheduler integration
- Background process automation in LAN environments

---

## Author

> Built as part of a network administration lab environment.

---

## License

MIT — free to use and modify.
