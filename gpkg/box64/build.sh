TERMUX_PKG_HOMEPAGE=https://github.com/ptitSeb/box64
TERMUX_PKG_DESCRIPTION="Linux Userspace x86_64 Emulator with a twist"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.3.1-474a43a
TERMUX_PKG_SRCURL=https://github.com/ptitSeb/box64/archive/474a43a424494acc8e3d62dc1de2038d97d16937.tar.gz
TERMUX_PKG_SHA256=f67982adcb85abae69a31cff90198de6ad02b3a4268161d0e32e13998d2d56e0
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_BLACKLISTED_ARCHES="arm, i686"
TERMUX_CMAKE_BUILD="Unix Makefiles"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/etc/binfmt.d"

termux_step_pre_configure() {
	if [ "${TERMUX_ARCH}" = "aarch64" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DARM_DYNAREC=ON"
	elif [ "${TERMUX_ARCH}" = "x86_64" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLD80BITS=1 -DNOALIGN=1"
	fi
}

termux_step_make_install() {
	if [ "${TERMUX_ARCH}" = "aarch64" ]; then
		make install
	elif [ "${TERMUX_ARCH}" = "x86_64" ]; then
		install -Dm755 box64 -t ${TERMUX_PREFIX}/bin/
	fi
}
