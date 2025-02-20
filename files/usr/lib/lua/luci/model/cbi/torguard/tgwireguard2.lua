-- Import the necessary LuCI modules
local uci = require("luci.model.uci").cursor()
local sys = require("luci.sys")
local util = require("luci.util")

-- Function to check if WireGuard (wg) is active
local function is_vpn_connected()
    local status = sys.call("ip link show wg >/dev/null 2>&1")
    return (status == 0) and "Connected" or "Disconnected"
end

-- Function to get RX and TX statistics for wg
local function get_vpn_traffic()
    local rx, tx = "N/A", "N/A"
    local f = io.popen("ifconfig wg | grep 'RX bytes' 2>/dev/null")
    if f then
        local output = f:read("*a")
        f:close()
        if output then
            rx = output:match("RX bytes:(%d+)") or "N/A"
            tx = output:match("TX bytes:(%d+)") or "N/A"
        end
    end
    return rx, tx
end

-- Define the model
m = Map("tgwireguard2_cfg", "TorGuard WireGuard Servers")

-- VPN Status Section
status_section = m:section(TypedSection, "wgconfig", "WireGuard VPN Status")
status_section.anonymous = true
status_section.addremove = false

status = status_section:option(DummyValue, "_vpn_status", translate("VPN Status"))
status.value = is_vpn_connected()

-- VPN Traffic Stats
rx, tx = get_vpn_traffic()
rx_stat = status_section:option(DummyValue, "_vpn_rx", translate("RX Bytes"))
rx_stat.value = rx .. " Bytes"

tx_stat = status_section:option(DummyValue, "_vpn_tx", translate("TX Bytes"))
tx_stat.value = tx .. " Bytes"

-- Define the section for the WireGuard settings
s = m:section(TypedSection, "wgconfig", "Enter your TorGuard login and choose a server.")
s.anonymous = true
s.addremove = false

-- Define the input fields for the AnyConnect settings
user = s:option(Value, "TGWG_USER", translate("VPN Username"))
pass = s:option(Value, "TGWG_PASS", translate("VPN Password"))
pass.password = true

svr = s:option(ListValue, "TGWG_URL", translate("VPN Server"))
-- Add all servers here
svr:value("ar.torguard.com", "Argentina")
svr:value("au.torguard.com", "Australia Sydney")
svr:value("aus.torguard.com", "Austria")
svr:value("bg.torguard.com", "Belgium")
svr:value("br.torguard.com", "Brazil 1")
svr:value("br2.torguard.com", "Brazil 2")
svr:value("bul.torguard.com", "Bulgaria")
svr:value("ca.torguard.com", "Canada Toronto")
svr:value("cavan.torguard.com", "Canada Vancouver")
svr:value("ch.torguard.com", "Chile")
svr:value("cz.torguard.com", "Czech Republic")
svr:value("dn.torguard.com", "Denmark")
svr:value("fn.torguard.com", "Finland")
svr:value("fr.torguard.com", "France")
svr:value("ger.torguard.com", "Germany")
svr:value("gre.torguard.com", "Greece")
svr:value("hk.torguard.com", "Hong Kong")
svr:value("hg.torguard.com", "Hungary")
svr:value("ice.torguard.com", "Iceland")
svr:value("in.torguard.com", "India Mumbai")
svr:value("ire.torguard.com", "Ireland")
svr:value("isr-loc1.torguard.com", "Israel Tel Aviv")
svr:value("it.torguard.com", "Italy")
svr:value("id.torguard.com", "Indonesia")
svr:value("jp.torguard.com", "Japan")
svr:value("lux.torguard.com", "Luxembourg")
svr:value("mx.torguard.com", "Mexico")
svr:value("md.torguard.com", "Moldova")
svr:value("nl.torguard.com", "Netherlands")
svr:value("nz.torguard.com", "New Zealand")
svr:value("no.torguard.com", "Norway")
svr:value("pl.torguard.com", "Poland")
svr:value("pg.torguard.com", "Portugal")
svr:value("ro.torguard.com", "Romania")
svr:value("ru.torguard.com", "Russia")
svr:value("sg.torguard.com", "Singapore")
svr:value("slk.torguard.com", "Slovakia")
svr:value("sp.torguard.com", "Spain")
svr:value("sk.torguard.com", "South Korea")
svr:value("sa.torguard.com", "South Africa")
svr:value("swe.torguard.com", "Sweden")
svr:value("swiss.torguard.com", "Switzerland")
svr:value("tw.torguard.com", "Taiwan")
svr:value("th.torguard.com", "Thailand")
svr:value("tk.torguard.com", "Turkey")
svr:value("uae.torguard.com", "UAE")
svr:value("uk.torguard.com", "UK London")
svr:value("uk.man.torguard.com", "UK Manchester")
svr:value("ukr.torguard.com", "Ukraine")
svr:value("us-fl.torguard.com", "USA Miami")
svr:value("us-atl.torguard.com", "USA Atlanta")
svr:value("us-ny.torguard.com", "USA New York")
svr:value("us-chi.torguard.com", "USA Chicago")
svr:value("us-chi-loc2.torguard.com", "USA Chicago 2")
svr:value("us-dal.torguard.com", "USA Dallas")
svr:value("us-dal-loc2.torguard.com", "USA Dallas 2")
svr:value("us-la.torguard.com", "USA LA")
svr:value("us-lv.torguard.com", "USA Las Vegas")
svr:value("us-sa.torguard.com", "USA Seattle")
svr:value("us-sf.torguard.com", "USA San Francisco")
svr:value("us-nj.torguard.com", "USA New Jersey")
svr:value("us-nj-loc2.torguard.com", "USA New Jersey 2")
svr:value("us-slc.torguard.com", "USA Salt Lake City")

w = m:section(TypedSection, "wgconfig", "WireGuard VPN Control: Start/Stop WireGuard After Saving Settings")

btnStop = w:option(Button, "_btn_start", translate("Click to Stop WireGuard"))
function btnStop.write()
    io.popen("/etc/init.d/tgwireguard2 stop")
end

btnStart = w:option(Button, "_btn_stop", translate("Click to Start WireGuard"))
function btnStart.write()
    io.popen("/etc/init.d/tgwireguard2 start")
end

-- Return the configuration page
return m
