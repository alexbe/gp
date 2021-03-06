# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="A file watching service."
HOMEPAGE="https://facebook.github.io/watchman/"

EGIT_REPO_URI="https://github.com/facebook/watchman.git"
if [[ ${PV} == "9999" ]]; then
	EGIT_COMMIT="master"
else
	EGIT_COMMIT="v${PV}"
fi
inherit git-2

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+python pcre"

DEPEND="python? ( dev-lang/python )"
RDEPEND="${DEPEND}"




src_configure() { 

  econf \
    --enable-statedir=/var/run/watchman \
    $(use_with python python)

}
