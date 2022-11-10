# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit linux-info

DESCRIPTION="SmartPhone Flash Tool for MTK based Android devices"
HOMEPAGE="http://spflashtool.com/"
SRC_URI="SP_Flash_Tool_v${PV}_Linux.zip"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+udev-rules"
#RESTRICT="fetch"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/libpng:1.2
	sys-apps/util-linux
	app-arch/bzip2"

S="${WORKDIR}/SP_Flash_Tool_v${PV}_Linux"

pkg_nofetch(){

        einfo "  Download manually:"
        einfo "  https://spflashtools.com/linux/sp-flash-tool-v${PV%%\.*}-${PV##*\.}-for-linux"
}


pkg_pretend(){
	ewarn "Checking for CONFIG_USB_ACM..."
	linux-info_pkg_setup
	if ! linux_config_exists || ! linux_chkconfig_present USB_ACM; then
		ewarn "Usb modem (CDC ACM) support is required"
	fi
}



src_install() {
	if use udev-rules; then
		insinto /lib/udev/rules.d/
		doins "${FILESDIR}/51-android.rules"
	fi
	local dest=/opt/${PN}
	dodir ${dest}
	insinto ${dest}
	insopts -m 0644
	doins -r *
	fperms 755 ${dest}/flash_tool ${dest}/libflashtool.so ${dest}/bin/assistant plugins/*/*.so
	newbin ${FILESDIR}/launcher.sh spflashtool
}

pkg_postinst(){
	ewarn "After first installation of udev rules run as root:"
	ewarn "# udevadm control --reload-rules"
	einfo "Latest version of udev rules can be found at
		https://github.com/M0Rf30/android-udev-rules"
}
