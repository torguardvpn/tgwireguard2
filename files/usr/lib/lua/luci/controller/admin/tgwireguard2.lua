module("luci.controller.admin.tgwireguard2", package.seeall)
function index()
	entry({"admin", "vpn", "tgwireguard2"}, cbi("torguard/tgwireguard2"), _("TorGuard Wireguard"), 102)
end
