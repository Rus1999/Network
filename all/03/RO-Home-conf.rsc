# aug/31/2022 11:43:38 by RouterOS 7.2.1
# software id = M2LV-NX37
#
# model = RouterBOARD 941-2nD
# serial number = 661706652A48
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether2 name=pppoe-out1 \
    use-peer-dns=yes user=ppp01
/interface vlan
add interface=ether4 name=eth4_VLAN10 vlan-id=10
add interface=ether4 name=eth4_VLAN20 vlan-id=20
add interface=ether4 name=eth4_VLAN30 vlan-id=30
/interface list
add name=WAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.1.2-172.16.1.254
add name=dhcp_pool1 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool2 ranges=10.20.10.2-10.20.10.254
add name=dhcp_pool3 ranges=10.30.10.2-10.30.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
add address-pool=dhcp_pool1 interface=eth4_VLAN10 lease-time=1d10m name=dhcp2
add address-pool=dhcp_pool2 interface=eth4_VLAN20 lease-time=1d10m name=dhcp3
add address-pool=dhcp_pool3 interface=eth4_VLAN30 lease-time=1d10m name=dhcp4
/interface list member
add interface=ether1 list=WAN
add interface=pppoe-out1 list=WAN
/ip address
add address=172.16.1.1/24 interface=ether3 network=172.16.1.0
add address=10.10.10.1/24 interface=eth4_VLAN10 network=10.10.10.0
add address=10.20.10.1/24 interface=eth4_VLAN20 network=10.20.10.0
add address=10.30.10.1/24 interface=eth4_VLAN30 network=10.30.10.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    10.10.10.1
add address=10.20.10.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    10.20.10.1
add address=10.30.10.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    10.30.10.1
add address=172.16.1.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    172.16.1.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=RO-Home
