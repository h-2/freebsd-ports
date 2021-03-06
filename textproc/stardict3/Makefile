# Created by: eric
# $FreeBSD$

PORTNAME=	stardict
PORTVERSION=	3.0.4
PORTREVISION=	2
CATEGORIES=	textproc
MASTER_SITES=	GOOGLE_CODE
DIST_SUBDIR=	stardict

MAINTAINER=	makc@FreeBSD.org
COMMENT=	Dictionary lookup program written in Gtk2

LIB_DEPENDS=	libsigc-2.0.so:${PORTSDIR}/devel/libsigc++20 \
		libenchant.so:${PORTSDIR}/textproc/enchant
RUN_DEPENDS=	xdg-open:${PORTSDIR}/devel/xdg-utils

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--disable-festival \
		--disable-gucharmap \
		--disable-espeak \
		--disable-tools \
		--disable-updateinfo
CPPFLAGS+=	-I${LOCALBASE}/include
LIBS+=		-L${LOCALBASE}/lib
USES=		gettext gmake libtool pathfix pkgconfig tar:bzip2
USE_GNOME=	intltool

PROJECTHOST=	stardict-3

OPTIONS_DEFINE=	GNOME
OPTIONS_SUB=	yes

GNOME_USE=	GNOME=gnomeprefix,gnomedocutils,libgnomeui
GNOME_USE_OFF=	GNOME=gtk20
GNOME_CONFIGURE_ENABLE=	gnome-support schemas-install scrollkeeper

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MGNOME}
GCONF_SCHEMAS=	stardict.schemas
INSTALLS_OMF=	yes
.endif

post-patch:
	@${REINPLACE_CMD} -e 's,/usr/share,${PREFIX}/share,g' \
		${WRKSRC}/dict/src/conf.cpp
	@${REINPLACE_CMD} \
		-e '/as_fn_error.*gnome-doc-utils/d' \
		-e '/DEP_MODULES=/s/"$$/ gmodule-2.0"/' \
		${WRKSRC}/dict/configure

post-patch-GNOME-off:
	${REINPLACE_CMD} -e '/^SUBDIRS/s,help,,' ${WRKSRC}/dict/Makefile.in

.include <bsd.port.mk>
