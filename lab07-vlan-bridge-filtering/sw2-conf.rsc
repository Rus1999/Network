# jan/02/1970 01:03:19 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface bridge
add ingress-filtering=no name=bridge1 vlan-filtering=yes
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2 pvid=20
add bridge=bridge1 interface=ether3 pvid=10
add bridge=bridge1 interface=ether4
/interface bridge vlan
add bridge=bridge1 tagged=ether1,ether4 vlan-ids=10
add bridge=bridge1 tagged=ether1,ether4 untagged=ether2 vlan-ids=20
add bridge=bridge1 tagged=ether1,ether4 vlan-ids=30
/system identity
set name=MikroTik24
/tool romon
set enabled=yes
