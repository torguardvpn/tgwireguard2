# TorGuard WireGuard OpenWRT App  

## Overview  
The **TorGuard WireGuard OpenWRT App** allows users to quickly and easily connect to any of TorGuard VPN's WireGuard locations. Just enter your **TorGuard username and password**, choose a **server from the dropdown**, and connect instantly.  

### Features:  
✅ **No need to import WireGuard configs** – The app works with TorGuard's WireGuard API.  
✅ **Auto cron polling** – Keeps the WireGuard connection alive indefinitely.  
✅ **Connection Status Display** – Easily check if the VPN is connected or disconnected.
✅ **RX/TX Traffic Info** – View real-time upload and download traffic statistics for WireGuard.
✅ **Seamless OpenWRT integration** – Easily install and manage from the OpenWRT web UI.  
✅ **Officially maintained by TorGuard** – Regular updates and support.  


---

## Installation Methods  

### 🔹 Compile from Source using OpenWRT SDK  

Follow these steps to build the package from source using the OpenWRT SDK:  

1. **Access OpenWRT SDK Directory**  
   ```bash
   cd ~/openwrt/package
   ```
   *(Ensure you have the OpenWRT SDK set up beforehand.)*  

2. **Clone the Repository**  
   ```bash
   git clone https://github.com/torguardvpn/tgwireguard2.git
   ```

3. **Compile the Package**  
   ```bash
   cd ~/openwrt
   make package/tgwireguard2/compile V=s
   ```

4. **Locate the `.ipk` File**  
   After compilation, the `.ipk` package will be found in:  
   ```
   ~/openwrt/bin/packages/<target_architecture>/base/tgwireguard2_2.0.9-r0_all.ipk
   ```
   *(Replace `<target_architecture>` with your OpenWRT device's architecture.)*  

---

### 🔹 Install Precompiled `.ipk` Package  

#### 📌 Method 1: Upload via OpenWRT Web UI  
1. **Download the `.ipk` file** from: https://github.com/torguardvpn/tgwireguard2/releases/download/v2.0.9-r0/tgwireguard2_2.0.9-r0_all.ipk  
2. **Log into OpenWRT Web Interface**.  
3. Navigate to **System → Software**.  
4. Click **Upload Package** and select the `.ipk` file.  
5. Click **Install** to complete the setup.  

#### 📌 Method 2: Install via `wget` (SSH)  
1. **SSH into your OpenWRT router**  
   ```bash
   ssh root@192.168.1.1
   ```

2. **Download and Install the Package**  
   ```bash
   cd /tmp
   wget [https://github.com/TorGuard/tgwireguard2/releases/latest/download/torguard-wireguard-openwrt.ipk](https://github.com/torguardvpn/tgwireguard2/releases/download/v2.0.9-r0/tgwireguard2_2.0.9-r0_all.ipk)
   opkg install tgwireguard2_2.0.9-r0_all.ipk
   ```

---

## Usage  

1. Open the **TorGuard WireGuard App** from OpenWRT's web interface.  
2. Enter your **TorGuard username and password**.  
3. Select your **preferred server** from the dropdown.  
4. Click **Connect** to establish a WireGuard VPN tunnel.  

Your connection will remain **active indefinitely**, thanks to **auto cron polling**.  

---

## Support & Updates  
This OpenWRT app is **officially maintained by TorGuard**.  
🔗 For support, visit: [TorGuard Support](https://torguard.net/)  
🚀 Stay updated on releases: ([GitHub Releases](https://github.com/torguardvpn/tgwireguard2/releases/))  

---

**Enjoy seamless and secure WireGuard VPN on OpenWRT with TorGuard!** 🎉
