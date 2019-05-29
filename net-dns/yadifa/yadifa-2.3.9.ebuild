# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=6

PKGSUFX=8497

DESCRIPTION="YADIFA is a name server implementation developed from scratch by .eu"
HOMEPAGE="https://www.yadifa.eu/"
SRC_URI="https://cdn.yadifa.eu/sites/default/files/releases/${P}-${PKGSUFX}.tar.gz"
 
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
 
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_unpack() {
	unpack ${A}
	mv  "${S}-${PKGSUFX}"  "${S}"
}

src_configure() {
  econf \
    --localstatedir=/var/lib/yadifa \
    --with-logdir=/var/log/yadifa \
    --with-tools \
    --enable-rrl \
    --enable-nsid \
    --enable-ctrl \
    --enable-dynamic-provisioning \
    --enable-messages \
    --enable-shared \
    --disable-static
}



src_install() {
	emake DESTDIR="${D}" install
	keepdir /var/lib/yadifa/ zones/xfr zones/slaves zones/keys
	keepdir /var/log/yadifa



}
