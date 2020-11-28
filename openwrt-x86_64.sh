#!/bin/bash

cd openwrt

# 安装额外依赖软件包
# sudo -E apt-get -y install rename

# 更新feeds文件
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' openwrt/feeds.conf.default #启用passwall
# cat feeds.conf.default

# 更新并安装源
./scripts/feeds clean
./scripts/feeds update -a && ./scripts/feeds install -a

# 添加第三方主题插件
git clone https://github.com/openwrt-develop/luci-theme-atmaterial package/openwrt-packages/luci-theme-atmaterial
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
git clone https://github.com/tty228/luci-app-serverchan package/openwrt-packages/luci-app-serverchan
git clone https://github.com/destan19/OpenAppFilter package/openwrt-packages/OpenAppFilter
# git clone https://github.com/vernesong/OpenClash package/openwrt-packages/luci-app-OpenClash

# 替换更新passwall和ssrplus+
rm -rf package/openwrt-packages/luci-app-passwall && svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/openwrt-packages/luci-app-passwall
rm -rf package/openwrt-packages/luci-app-ssr-plus && svn co https://github.com/fw876/helloworld package/openwrt-packages/helloworld

# 添加passwall依赖库
# git clone https://github.com/kenzok8/small package/small
svn co https://github.com/xiaorouji/openwrt-package/trunk/package package/small

# 替换https-dns-proxy.init文件,解决用LEDE源码加入passwall编译固件后DNS转发127.0.0.1#5053和12.0.0.1#5054问题
curl -fsSL  https://raw.githubusercontent.com/Lienol/openwrt-packages/19.07/net/https-dns-proxy/files/https-dns-proxy.init > feeds/packages/net/https-dns-proxy/files/https-dns-proxy.init

#创建自定义配置文件

rm -f ./.config*
touch ./.config

# 主体配置
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
CONFIG_DOCKER_KERNEL_OPTIONS=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_DOCKER_RES_SHAPE=y
CONFIG_DOCKER_STO_EXT4=y
# CONFIG_DRIVER_11AC_SUPPORT is not set
# CONFIG_DRIVER_11N_SUPPORT is not set
# CONFIG_DRIVER_11W_SUPPORT is not set
CONFIG_KERNEL_BLK_DEV_THROTTLING=y
CONFIG_KERNEL_CFQ_GROUP_IOSCHED=y
CONFIG_KERNEL_CFS_BANDWIDTH=y
CONFIG_KERNEL_CGROUP_PERF=y
CONFIG_KERNEL_EXT4_FS_POSIX_ACL=y
CONFIG_KERNEL_FS_POSIX_ACL=y
CONFIG_KERNEL_IPC_NS=y
CONFIG_KERNEL_KEYS=y
CONFIG_KERNEL_MEMCG_SWAP=y
CONFIG_KERNEL_MEMCG_SWAP_ENABLED=y
CONFIG_KERNEL_NAMESPACES=y
CONFIG_KERNEL_NET_NS=y
CONFIG_KERNEL_PERF_EVENTS=y
CONFIG_KERNEL_PID_NS=y
CONFIG_KERNEL_USER_NS=y
CONFIG_KERNEL_UTS_NS=y
# CONFIG_PACKAGE_UnblockNeteaseMusic is not set
# CONFIG_PACKAGE_UnblockNeteaseMusicGo is not set
# CONFIG_PACKAGE_alsa-lib is not set
# CONFIG_PACKAGE_alsa-utils is not set
# CONFIG_PACKAGE_amule is not set
# CONFIG_PACKAGE_ath9k-htc-firmware is not set
# CONFIG_PACKAGE_avahi-dbus-daemon is not set
# CONFIG_PACKAGE_boost-chrono is not set
# CONFIG_PACKAGE_boost-random is not set
CONFIG_PACKAGE_btrfs-progs=y
# CONFIG_PACKAGE_ca-bundle is not set
CONFIG_PACKAGE_cgroupfs-mount=y
# CONFIG_PACKAGE_confuse is not set
CONFIG_PACKAGE_containerd=y
# CONFIG_PACKAGE_dbus is not set
CONFIG_PACKAGE_docker-ce=y
# CONFIG_PACKAGE_fdk-aac is not set
# CONFIG_PACKAGE_forked-daapd is not set
CONFIG_PACKAGE_frpc=y
# CONFIG_PACKAGE_hostapd-common is not set
# CONFIG_PACKAGE_icu is not set
CONFIG_PACKAGE_iptables-mod-conntrack-extra=y
CONFIG_PACKAGE_iptables-mod-extra=y
CONFIG_PACKAGE_iptables-mod-ipopt=y
# CONFIG_PACKAGE_iptables-mod-ipsec is not set
# CONFIG_PACKAGE_iw is not set
CONFIG_PACKAGE_kcptun-client=y
# CONFIG_PACKAGE_kmod-ath is not set
# CONFIG_PACKAGE_kmod-ath10k is not set
# CONFIG_PACKAGE_kmod-ath5k is not set
# CONFIG_PACKAGE_kmod-ath9k is not set
# CONFIG_PACKAGE_kmod-ath9k-htc is not set
CONFIG_PACKAGE_kmod-br-netfilter=y
# CONFIG_PACKAGE_kmod-cfg80211 is not set
# CONFIG_PACKAGE_kmod-crypto-cbc is not set
# CONFIG_PACKAGE_kmod-crypto-deflate is not set
# CONFIG_PACKAGE_kmod-crypto-des is not set
# CONFIG_PACKAGE_kmod-crypto-echainiv is not set
# CONFIG_PACKAGE_kmod-crypto-hmac is not set
# CONFIG_PACKAGE_kmod-crypto-md5 is not set
# CONFIG_PACKAGE_kmod-crypto-rng is not set
# CONFIG_PACKAGE_kmod-crypto-sha256 is not set
# CONFIG_PACKAGE_kmod-crypto-wq is not set
CONFIG_PACKAGE_kmod-dax=y
CONFIG_PACKAGE_kmod-dm=y
CONFIG_PACKAGE_kmod-dnsresolver=y
CONFIG_PACKAGE_kmod-dummy=y
CONFIG_PACKAGE_kmod-fs-nfs=y
CONFIG_PACKAGE_kmod-fs-nfs-common=y
CONFIG_PACKAGE_kmod-fs-nfs-v3=y
CONFIG_PACKAGE_kmod-fs-nfs-v4=y
CONFIG_PACKAGE_kmod-fs-ntfs=y
CONFIG_PACKAGE_kmod-fs-squashfs=y
CONFIG_PACKAGE_kmod-ikconfig=y
# CONFIG_PACKAGE_kmod-ipsec is not set
CONFIG_PACKAGE_kmod-ipt-conntrack-extra=y
CONFIG_PACKAGE_kmod-ipt-extra=y
CONFIG_PACKAGE_kmod-ipt-ipopt=y
# CONFIG_PACKAGE_kmod-ipt-ipsec is not set
# CONFIG_PACKAGE_kmod-iptunnel6 is not set
CONFIG_PACKAGE_kmod-lib-crc32c=y
# CONFIG_PACKAGE_kmod-mac80211 is not set
CONFIG_PACKAGE_kmod-nf-ipvs=y
# CONFIG_PACKAGE_kmod-rt2800-usb is not set
# CONFIG_PACKAGE_kmod-rt2x00-lib is not set
# CONFIG_PACKAGE_kmod-sound-core is not set
# CONFIG_PACKAGE_kmod-tun is not set
CONFIG_PACKAGE_kmod-veth=y
# CONFIG_PACKAGE_lame-lib is not set
# CONFIG_PACKAGE_libalac is not set
# CONFIG_PACKAGE_libantlr3c is not set
# CONFIG_PACKAGE_libatomic is not set
CONFIG_PACKAGE_libattr=y
# CONFIG_PACKAGE_libavahi-client is not set
# CONFIG_PACKAGE_libavahi-dbus-support is not set
# CONFIG_PACKAGE_libbfd is not set
# CONFIG_PACKAGE_libbz2 is not set
# CONFIG_PACKAGE_libcares is not set
# CONFIG_PACKAGE_libconfig is not set
# CONFIG_PACKAGE_libcryptopp is not set
# CONFIG_PACKAGE_libcurl is not set
# CONFIG_PACKAGE_libdaemon is not set
# CONFIG_PACKAGE_libdb47 is not set
# CONFIG_PACKAGE_libdbus is not set
CONFIG_PACKAGE_libdevmapper=y
# CONFIG_PACKAGE_libdouble-conversion is not set
# CONFIG_PACKAGE_libexpat is not set
# CONFIG_PACKAGE_libffi is not set
# CONFIG_PACKAGE_libffmpeg-full is not set
# CONFIG_PACKAGE_libgcrypt is not set
# CONFIG_PACKAGE_libgdbm is not set
# CONFIG_PACKAGE_libgmp is not set
# CONFIG_PACKAGE_libgnutls is not set
# CONFIG_PACKAGE_libgpg-error is not set
# CONFIG_PACKAGE_libhttp-parser is not set
# CONFIG_PACKAGE_libminiupnpc is not set
CONFIG_PACKAGE_libmount=y
# CONFIG_PACKAGE_libnatpmp is not set
# CONFIG_PACKAGE_libnettle is not set
CONFIG_PACKAGE_libnetwork=y
# CONFIG_PACKAGE_libnghttp2 is not set
# CONFIG_PACKAGE_libopus is not set
# CONFIG_PACKAGE_libpcre2-16 is not set
# CONFIG_PACKAGE_libplist is not set
# CONFIG_PACKAGE_libpng is not set
# CONFIG_PACKAGE_libpopt is not set
# CONFIG_PACKAGE_libprotobuf-c is not set
# CONFIG_PACKAGE_libsoxr is not set
# CONFIG_PACKAGE_libsqlite3 is not set
# CONFIG_PACKAGE_libunistring is not set
# CONFIG_PACKAGE_libupnp is not set
CONFIG_PACKAGE_libwebsockets-full=y
# CONFIG_PACKAGE_libwebsockets-openssl is not set
# CONFIG_PACKAGE_libwxbase is not set
# CONFIG_PACKAGE_libxml2 is not set
# CONFIG_PACKAGE_libzstd is not set
# CONFIG_PACKAGE_luci-app-airplay2 is not set
# CONFIG_PACKAGE_luci-app-amule is not set
# CONFIG_PACKAGE_luci-app-autoreboot is not set
CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_PACKAGE_luci-app-frpc=y
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set
# CONFIG_PACKAGE_luci-app-music-remote-center is not set
CONFIG_PACKAGE_luci-app-mwan3=y
CONFIG_PACKAGE_luci-app-mwan3helper=y
# CONFIG_PACKAGE_luci-app-openvpn-server is not set
# CONFIG_PACKAGE_luci-app-qbittorrent is not set
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-ttyd=y
# CONFIG_PACKAGE_luci-app-unblockmusic is not set
CONFIG_PACKAGE_luci-app-webadmin=y
CONFIG_PACKAGE_luci-app-wrtbwmon=y
# CONFIG_PACKAGE_luci-app-xlnetacc is not set
# CONFIG_PACKAGE_luci-app-zerotier is not set
CONFIG_PACKAGE_luci-i18n-dockerman-zh-cn=y
CONFIG_PACKAGE_luci-i18n-mwan3-zh-cn=y
CONFIG_PACKAGE_luci-i18n-mwan3helper-zh-cn=y
CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn=y
CONFIG_PACKAGE_luci-i18n-webadmin-zh-cn=y
CONFIG_PACKAGE_luci-i18n-wrtbwmon-zh-cn=y
CONFIG_PACKAGE_mount-utils=y
CONFIG_PACKAGE_mwan3=y
# CONFIG_PACKAGE_mxml is not set
# CONFIG_PACKAGE_node is not set
# CONFIG_PACKAGE_openvpn-easy-rsa is not set
# CONFIG_PACKAGE_openvpn-openssl is not set
# CONFIG_PACKAGE_python is not set
# CONFIG_PACKAGE_python-base is not set
# CONFIG_PACKAGE_python-codecs is not set
# CONFIG_PACKAGE_python-compiler is not set
# CONFIG_PACKAGE_python-ctypes is not set
# CONFIG_PACKAGE_python-db is not set
# CONFIG_PACKAGE_python-decimal is not set
# CONFIG_PACKAGE_python-distutils is not set
# CONFIG_PACKAGE_python-email is not set
# CONFIG_PACKAGE_python-gdbm is not set
# CONFIG_PACKAGE_python-light is not set
# CONFIG_PACKAGE_python-logging is not set
# CONFIG_PACKAGE_python-multiprocessing is not set
# CONFIG_PACKAGE_python-ncurses is not set
# CONFIG_PACKAGE_python-openssl is not set
# CONFIG_PACKAGE_python-pydoc is not set
# CONFIG_PACKAGE_python-sqlite3 is not set
# CONFIG_PACKAGE_python-unittest is not set
# CONFIG_PACKAGE_python-xml is not set
# CONFIG_PACKAGE_qBittorrent is not set
# CONFIG_PACKAGE_qt5-core is not set
# CONFIG_PACKAGE_qt5-network is not set
# CONFIG_PACKAGE_qt5-xml is not set
# CONFIG_PACKAGE_rblibtorrent is not set
# CONFIG_PACKAGE_rt2800-usb-firmware is not set
CONFIG_PACKAGE_runc=y
# CONFIG_PACKAGE_shairport-sync-openssl is not set
# CONFIG_PACKAGE_sqlite3-cli is not set
# CONFIG_PACKAGE_strongswan is not set
# CONFIG_PACKAGE_strongswan-charon is not set
# CONFIG_PACKAGE_strongswan-ipsec is not set
# CONFIG_PACKAGE_strongswan-minimal is not set
# CONFIG_PACKAGE_strongswan-mod-aes is not set
# CONFIG_PACKAGE_strongswan-mod-gmp is not set
# CONFIG_PACKAGE_strongswan-mod-hmac is not set
# CONFIG_PACKAGE_strongswan-mod-kernel-netlink is not set
# CONFIG_PACKAGE_strongswan-mod-nonce is not set
# CONFIG_PACKAGE_strongswan-mod-pubkey is not set
# CONFIG_PACKAGE_strongswan-mod-random is not set
# CONFIG_PACKAGE_strongswan-mod-sha1 is not set
# CONFIG_PACKAGE_strongswan-mod-socket-default is not set
# CONFIG_PACKAGE_strongswan-mod-stroke is not set
# CONFIG_PACKAGE_strongswan-mod-updown is not set
# CONFIG_PACKAGE_strongswan-mod-x509 is not set
# CONFIG_PACKAGE_strongswan-mod-xauth-generic is not set
# CONFIG_PACKAGE_strongswan-mod-xcbc is not set
CONFIG_PACKAGE_tini=y
CONFIG_PACKAGE_ttyd=y
# CONFIG_PACKAGE_wireless-regdb is not set
# CONFIG_PACKAGE_wpad is not set
# CONFIG_PACKAGE_zerotier is not set
CONFIG_TARGET_IMAGES_GZIP=y
CONFIG_TARGET_KERNEL_PARTSIZE=300
CONFIG_TARGET_ROOTFS_PARTSIZE=500
EOF

# LuCI主题
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-theme-netgear=y
CONFIG_PACKAGE_luci-theme-argon-dark-mod=y
CONFIG_PACKAGE_luci-theme-argon-light-mod=y
CONFIG_PACKAGE_luci-theme-bootstrap-mod=y
CONFIG_PACKAGE_luci-theme-netgear-mc=y
EOF

# 第三方主题插件
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-atmaterial=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-oaf=y
CONFIG_PACKAGE_luci-app-serverchan=y
CONFIG_PACKAGE_luci-app-adguardhome=y
EOF

# 常用软件包
# cat >> .config <<EOF
# CONFIG_PACKAGE_curl=y
# CONFIG_PACKAGE_htop=y
# CONFIG_PACKAGE_nano=y
# CONFIG_PACKAGE_screen=y
# CONFIG_PACKAGE_tree=y
# CONFIG_PACKAGE_vim-fuller=y
# CONFIG_PACKAGE_wget=y
# EOF

sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
