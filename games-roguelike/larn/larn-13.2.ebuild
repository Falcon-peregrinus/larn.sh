
EAPI=5
inherit eutils vcs-snapshot user games

DESCRIPTION="Larn is a roguelike computer game authored by Noah Morgan in 1986 for the UNIX operating system."
HOMEPAGE="https://github.com/atsb/RL_M/releases"
SRC_URI="https://github.com/atsb/RL_M/archive/${PV}.tar.gz -> ${P}.tar.gz
"
#https://github.com/atsb/RL_M/releases/download/${PV}/Larn13_2_GNULINUX.zip -> ${P}-data.zip

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86"

RDEPEND=""
DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${P}.tar.gz
#	unpack ${P}-data.zip
}

S="${WORKDIR}/RL_M-${PV}"
src_prepare() {
	cd ${S}
	cp -R ../Larn13_GNULINUX/data/ .
	cp gnulinuxrelease.mak Makefile
	ls -al
	cp "${FILESDIR}"/larn.sh .
}

src_install() {
	mv  larn*_gnulinux larn
	#mkdir -p /usr/games/lib/larn/
	insinto /usr/games/lib/larn/data
	doins data/*
	insinto /usr/games/lib/larn/docs
	doins docs/*
	exeinto /usr/games/lib/larn/
	doexe larn
	dogamesbin larn.sh
}

