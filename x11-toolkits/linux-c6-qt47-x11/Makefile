# Created by: Artyom Mirgorodskiy <artyom.mirgorodsky@gmail.com>
# $FreeBSD$

PORTNAME=	qt47-x11
PORTVERSION=	4.7.2
PORTREVISION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=	 https://www.mirrorservice.org/sites/dl.atrpms.net/el6-${LINUX_REPO_ARCH}/atrpms/testing/ LOCAL/xmj
DIST_SUBDIR=	rpm/${LINUX_RPM_ARCH}/atrpms/6

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	RPM of QT4 (Linux CentOS 6)

ONLY_FOR_ARCHS=	i386 amd64
SRC_DISTFILES:=		# unretrievable.

USE_LINUX=	c6
USE_LDCONFIG=	yes

OPTIONS_DEFINE=	NVIDIA_GL

NVIDIA_GL_RUN_DEPENDS=	${LINUXBASE}/usr/lib/libGL.so.1:${PORTSDIR}/x11/nvidia-driver \
			linux-c6-libGLU>0:${PORTSDIR}/graphics/linux-c6-libGLU
NVIDIA_GL_USE_OFF=	linux_apps=dri

USE_LINUX_APPS=	fontconfig png xorglibs png alsalib jpeg tiff qt47
USE_LINUX_RPM=	yes
RPMVERSION=	1_18.el6

DESCR=	${.CURDIR}/../../devel/qt4/pkg-descr

post-patch:
	${RM} -f ${WRKSRC}/usr/share/qt47/translations/qt_help_*.qm

.include <bsd.port.mk>
