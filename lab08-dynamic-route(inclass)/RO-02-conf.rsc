# jan/02/1970 02:22:29 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface bridge
add name=loopback
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.20.2-192.168.20.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/routing id
add disabled=no id=10.2.2.2 name=id-1 select-dynamic-id=""
/routing ospf instance
add disabled=no name=ospf-instance-1 router-id=id-1
/routing ospf area
add disabled=no instance=ospf-instance-1 name=backbone
/ip address
add address=10.1.10.2/30 interface=ether1 network=10.1.10.0
add address=10.2.10.1/30 interface=ether4 network=10.2.10.0
add address=192.168.20.1/24 interface=ether3 network=192.168.20.0
add address=10.2.2.2 interface=loopback network=10.2.2.2
/ip dhcp-server network
add address=192.168.20.0/24 dns-server=10.202.1.5,10.202.1.6 gateway=\
    192.168.20.1
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=10.1.10.1 routing-table=main \
    suppress-hw-offload=no
/routing ospf interface-template
add area=backbone auth=md5 auth-key=1234 disabled=no interfaces=ether1,ether4 \
    type=ptp
add area=backbone disabled=yes interfaces=ether1 type=ptp
add area=backbone disabled=yes interfaces=ether4 type=ptp
add area=backbone auth=md5 auth-key=1234 disabled=no interfaces=all passive
/system identity
set name="24(RO-02)"
/tool romon
set enabled=yes
