# $FreeBSD$

PORTNAME=	asclock-gtk
PORTVERSION=	2.1.10
PORTREVISION=	9
CATEGORIES=	x11-clocks afterstep windowmaker
MASTER_SITES=	LOCAL/kuriyama
DISTNAME=	${PORTNAME}-${PORTVERSION}beta

MAINTAINER=	kuriyama@FreeBSD.org
COMMENT=	New flavor of asclock (GTK version)

WRKSRC=		${WRKDIR}/${PORTNAME}
ALL_TARGET=	asclock
INSTALL_TARGET=	install PREFIX=${STAGEDIR}${PREFIX}

USE_XORG=	x11 xt
USE_GNOME=	gtk12
HAS_CONFIGURE=	yes

MAKE_JOBS_UNSAFE=	yes

OPTIONS_SINGLE=		DEFTHEME
OPTIONS_SINGLE_DEFTHEME=FREEAMP_THEME NEWSTONE_THEME ORB_THEME \
			STONE_THEME ANALOG_THEME BEATS_THEME CLASSIC_THEME \
			PENGUIN_THEME SHAPED_THEME
OPTIONS_DEFAULT=	CLASSIC_THEME

FREEAMP_THEME_DESC=	Freeamp theme
NEWSTONE_THEME_DESC=	Newstone theme
ORB_THEME_DESC=		Orb theme
STONE_THEME_DESC=	Stone theme
ANALOG_THEME_DESC=	Analog theme
BEATS_THEME_DESC=	Beats theme
CLASSIC_THEME_DESC=	Classic theme
PENGUIN_THEME_DESC=	Penguin theme
SHAPED_THEME_DESC=	Shaped theme

do-configure:
	@(cd ${WRKSRC}; \
	  ${RM} -rf default_theme; \
	  ${LN} -s themes/${PORT_OPTIONS:M*_THEME:S/_THEME//:tl} default_theme)

.include <bsd.port.mk>
