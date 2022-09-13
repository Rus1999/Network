# jan/02/1970 01:05:15 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface bridge
add ingress-filtering=no name=bridge1 vlan-filtering=yes
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2 pvid=10
add bridge=bridge1 interface=ether3 pvid=30
add bridge=bridge1 interface=ether4 pvid=20
/interface bridge vlan
add bridge=bridge1 tagged=ether1 untagged=ether2 vlan-ids=10
add bridge=bridge1 tagged=ether1 untagged=ether4 vlan-ids=20
add bridge=bridge1 tagged=ether1 untagged=ether3 vlan-ids=30
/system identity
set name=MikroTik03
/tool romon
set enabled=yes
