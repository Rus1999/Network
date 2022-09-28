# sep/14/2022 11:36:45 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether2 name=pppoe-out1 \
    use-peer-dns=yes user=ppp01
/interface vlan
add interface=ether4 name=eth4_VLAN10 vlan-id=10
add arp=reply-only interface=ether4 name=eth4_VLAN20 vlan-id=20
add interface=ether4 name=eth4_VLAN30 vlan-id=30
add interface=ether4 name=ether4-vlan88 vlan-id=88
add interface=ether4 name=ether4-vlan99 vlan-id=99
/interface list
add name=WAN
add name=WIFI
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
add dns-name=login.demo hotspot-address=10.99.10.1 name=hsprof1
add dns-name=login.demo hotspot-address=10.88.10.1 name=hsprof2
/ip pool
add name=dhcp_pool0 ranges=172.16.1.2-172.16.1.254
add name=dhcp_pool1 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool2 ranges=10.20.10.2-10.20.10.254
add name=dhcp_pool3 ranges=10.30.10.2-10.30.10.254
add name=hs-pool-11 ranges=10.99.10.2-10.99.10.254
add name=hs-pool-10 ranges=10.88.10.2-10.88.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
add address-pool=dhcp_pool1 interface=eth4_VLAN10 lease-time=1d10m name=dhcp2
add add-arp=yes address-pool=dhcp_pool2 interface=eth4_VLAN20 lease-time=\
    1d10m name=dhcp3
add address-pool=dhcp_pool3 interface=eth4_VLAN30 lease-time=1d10m name=dhcp4
add address-pool=hs-pool-11 interface=ether4-vlan99 lease-time=1h name=dhcp5
add address-pool=hs-pool-10 interface=ether4-vlan88 lease-time=1h name=dhcp6
/ip hotspot
add address-pool=hs-pool-11 disabled=no interface=ether4-vlan99 name=hotspot1 \
    profile=hsprof1
add address-pool=hs-pool-10 disabled=no interface=ether4-vlan88 name=\
    hs-ether4-vlan88 profile=hsprof2
/interface list member
add interface=ether1 list=WAN
add interface=pppoe-out1 list=WAN
add interface=eth4_VLAN10 list=WIFI
add interface=eth4_VLAN20 list=WIFI
/ip address
add address=172.16.1.1/24 interface=ether3 network=172.16.1.0
add address=10.10.10.1/24 interface=eth4_VLAN10 network=10.10.10.0
add address=10.20.10.1/24 interface=eth4_VLAN20 network=10.20.10.0
add address=10.30.10.1/24 interface=eth4_VLAN30 network=10.30.10.0
add address=10.88.10.1/24 interface=ether4-vlan88 network=10.88.10.0
add address=10.99.10.0/24 interface=ether4-vlan99 network=10.99.10.0
add address=10.99.10.1/24 comment="hotspot network" interface=ether4-vlan99 \
    network=10.99.10.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    10.10.10.1
add address=10.20.10.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    10.20.10.1
add address=10.30.10.0/24 gateway=10.30.10.1
add address=10.88.10.0/24 comment="hotspot network" gateway=10.88.10.1
add address=10.99.10.0/24 comment="hotspot network" gateway=10.99.10.1
add address=172.16.1.0/24 dns-server=10.202.1.5,10.202.1.6,10.4.1.11 gateway=\
    172.16.1.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=10.30.10.1 name=www.democonf.co
/ip firewall address-list
add address=10.30.10.253 list=Blocked
add address=146.88.59.0/24 list=facebook
add address=74.119.76.0/22 list=facebook
add address=45.64.40.0/22 list=facebook
add address=69.63.176.0/20 list=facebook
add address=31.13.64.0/18 list=facebook
add address=66.220.144.0/20 list=facebook
add address=69.171.224.0/19 list=facebook
add address=103.4.96.0/22 list=facebook
add address=173.252.64.0/19 list=facebook
add address=173.252.96.0/19 list=facebook
add address=179.60.192.0/22 list=facebook
add address=204.15.20.0/22 list=facebook
add address=31.13.24.0/21 list=facebook
add address=199.201.64.0/22 list=facebook
add address=185.60.216.0/22 list=facebook
add address=157.240.0.0/16 list=facebook
add address=129.205.94.0/23 list=facebook
add address=31.12.0.0/15 list=facebook
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward comment="drop wifi" disabled=yes \
    in-interface-list=WIFI out-interface-list=WAN
add action=drop chain=forward comment="Block 10.30.10.253" disabled=yes \
    src-address-list=!Blocked
add action=drop chain=forward comment="Block Facebook" disabled=yes \
    dst-address-list=facebook
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface-list=WAN
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.99.10.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.88.10.0/24
/ip hotspot user
add name=admin
add name=rus
/ip service
set telnet disabled=yes
set ftp disabled=yes
set ssh disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=RO-Home
/tool romon
set enabled=yes
