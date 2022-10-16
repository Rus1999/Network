# oct/17/2022 00:06:32 by RouterOS 7.4
# software id = YQ5A-GPPK
#
# model = RouterBOARD 941-2nD
# serial number = 661705430745
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-256-cbc,aes-192-cbc lifetime=0s \
    pfs-group=none
/ip pool
add name=dhcp_pool0 ranges=192.168.3.2-192.168.3.254
add name=pptp_pool ranges=172.21.12.2-172.21.12.254
add name=l2tp_pool ranges=172.16.61.2-172.16.61.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=1d10m name=dhcp1
/ppp profile
add local-address=172.21.12.1 name=pptp_profile remote-address=pptp_pool \
    use-encryption=yes
add local-address=172.16.61.1 name=l2tp_profile remote-address=l2tp_pool \
    use-encryption=required
add name=isp01_profile on-up=":local newgw [/ip address get [find interface=\"\
    pppoe-out1\"] network];\r\
    \n:local routegw [/ip route get [find comment=\"ISP01\"] gateway ];\r\
    \n:if (\$newgw != \$routegw) do={ /ip route set [find comment=\"ISP01\"] g\
    ateway=\$newgw;}"
add name=isp02_profile on-up=":local newgw [/ip address get [find interface=\"\
    pppoe-out2\"] network];\r\
    \n:local routegw [/ip route get [find comment=\"ISP02\"] gateway ];\r\
    \n:if (\$newgw != \$routegw) do={ /ip route set [find comment=\"ISP02\"] g\
    ateway=\$newgw;}"
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 keepalive-timeout=20 \
    name=pppoe-out1 profile=isp01_profile use-peer-dns=yes user=ppp01@isp01
add add-default-route=yes default-route-distance=2 disabled=no interface=\
    ether2 keepalive-timeout=20 name=pppoe-out2 profile=isp02_profile \
    use-peer-dns=yes user=ppp01@isp02
/interface l2tp-server server
set default-profile=l2tp_profile enabled=yes use-ipsec=yes
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set enabled=yes
/ip address
add address=192.168.3.1/24 interface=ether3 network=192.168.3.0
add address=192.168.250.1/24 disabled=yes interface=ether2 network=\
    192.168.250.0
/ip dhcp-server network
add address=192.168.3.0/24 gateway=192.168.3.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=input dst-port=500,4500,1701 protocol=udp
add action=accept chain=input protocol=ipsec-esp
add action=accept chain=input protocol=ipsec-ah
/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-out1
add action=masquerade chain=srcnat out-interface=pppoe-out2
/ip route
add check-gateway=ping disabled=no distance=1 dst-address=192.168.200.0/24 \
    gateway=172.16.61.5 pref-src="" routing-table=main scope=30 \
    suppress-hw-offload=no target-scope=10
add check-gateway=ping comment=ISP02 disabled=no distance=1 dst-address=\
    1.1.1.1/32 gateway=172.31.255.1 pref-src="" routing-table=main scope=30 \
    suppress-hw-offload=no target-scope=10
add check-gateway=ping comment=ISP01 disabled=no distance=1 dst-address=\
    8.8.8.8/32 gateway=10.100.10.1 pref-src="" routing-table=main scope=30 \
    suppress-hw-offload=no target-scope=10
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    1.1.1.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=30
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    8.8.8.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=30
/ppp secret
add name=pptp01 profile=pptp_profile service=pptp
add name=pptp02 profile=pptp_profile service=pptp
add local-address=172.16.61.1 name=l2tp01 remote-address=172.16.61.5 service=\
    l2tp
add name=l2tp02 profile=l2tp_profile service=l2tp
/system clock
set time-zone-name=Asia/Bangkok
/system identity
set name=24-HQ
/tool romon
set enabled=yes
