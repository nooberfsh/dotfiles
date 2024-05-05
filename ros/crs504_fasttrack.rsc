# model = CRS504-4XQ
# CRS504 一个有 4 个物理接口,每个接口由4个 ethernet interface 组成
# 这里在每个物理接口(4各interface) 上创建一个 vlan, 同时开启了 inter vlan routing, vlan 结构如下:
# vlan name, vlanid, ip
# vlan100, 100, 10.1.1.1/24
# vlan200, 200, 10.1.2.1/24
# vlan300, 300, 10.1.3.1/24
# vlan400, 400, 10.1.4.1/24

:local mybridge "mybridge"
:local mymtu 9000
:local myl2mtu 9900

/interface/ethernet/switch
set 0 l3-hw-offloading=no

# 清除所有 vlan 设置
/interface bridge
remove [find]
/interface bridge port
remove [find]
/interface bridge vlan
remove [find]
/interface vlan
remove [find]
/ip/address
remove [find network~"10.1"]
/ip firewall filter
remove [find where action!=passthrough]
/interface list member
remove [find]
/interface list
remove [find name=MGMT]


# 创建 bridge
/interface bridge
:put "create bridge: $($mybridge)"
add frame-types=admit-only-vlan-tagged name=$mybridge vlan-filtering=yes


# 设置 mtu, l2mtu
/interface ethernet
:foreach x in=[find name~"qsfp28"] do={
    set $x mtu=$mymtu l2mtu=$myl2mtu
}

# 每个端口关闭 L3-HW-OFFLOADING, 所有的包先经过 firewall，通过 fasttrack 来卸载
/interface/ethernet/switch/port
:foreach x in=[find name~"qsfp28"] do={
    set $x l3-hw-offloading=no
}

# 设置第一组接口为管理接口
/interface list
add name=MGMT
/interface list member
add interface="vlan100" list=MGMT
add interface="ether1" list=MGMT


/ip firewall filter
add chain=input action=drop in-interface-list=!MGMT comment="只有管理接口才能访问这个设备"
add chain=input connection-state=invalid action=drop comment="Drop Invalid connections"
add action=fasttrack-connection chain=forward connection-state=established,related hw-offload=yes
add action=accept chain=forward connection-state=established,related


# 给 bridge 创建 4 个 vlan
:foreach i in={1;2;3;4} do={
    :local vlanid ($i * 100)
    :local vname "vlan$($vlanid)"
    :put "vlanid=$($vlanid), vlanname=$($vname)"
    # 每个 vlan 由 4各端口组成
    :foreach j in={1;2;3;4} do= {
        :local inname ("qsfp28-$($i)-$($j)")
        :put ("add bridge port interface=$($inname) pvid=$($vlanid)")
        /interface bridge port
        add bridge=$mybridge frame-types=admit-only-untagged-and-priority-tagged interface=$inname pvid=$vlanid
    }
    :put "create bridge vlan"
    /interface bridge vlan
    add bridge=$mybridge tagged=$mybridge vlan-ids=$vlanid

    :put "create interface vlan"
    /interface vlan
    add interface=$mybridge name=$vname vlan-id=$vlanid mtu=$mymtu

    :put "assign ip to vlan"
    /ip/address
    add address="10.1.$($i).1/24" interface=$vname
}


/interface/ethernet/switch
set 0 l3-hw-offloading=yes

