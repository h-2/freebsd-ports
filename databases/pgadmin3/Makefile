# Created by: Max Khon
# $FreeBSD$

PORTNAME=	pgadmin3
PORTVERSION=	1.22.1
PORTREVISION=	0
CATEGORIES=	databases
MASTER_SITES=	PGSQL/pgadmin3/release/v${PORTVERSION}/src
DIST_SUBDIR=	postgresql

MAINTAINER=	fjoe@FreeBSD.org
COMMENT=	PostgreSQL database design and management system

LICENSE=	PostgreSQL

BUILD_DEPENDS=	sphinx-build:${PORTSDIR}/textproc/py-sphinx

USES=		gettext gmake pgsql:9.0+
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--with-wx-version=${USE_WX} --enable-databasedesigner
USE_GNOME=	libxml2 libxslt
USE_WX=		2.8
WX_COMPS=	wx contrib

PLIST_FILES=	bin/pgadmin3
PORTDATA=	*

post-patch:
	@${REINPLACE_CMD} -e 's,/wx-config,/${WX_CONFIG:T},' ${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's,wxrc,wxrc-gtk2u-2.8,' ${WRKSRC}/pgadmin/ui/embed-xrc
	@${REINPLACE_CMD} -e 's,/usr/bin/xterm,${LOCALBASE}/bin/xterm,' ${WRKSRC}/plugins.d/plugins.ini
	@${REINPLACE_CMD} -e 's,/bin/bash,/bin/sh,' ${WRKSRC}/pgadmin/ver_svn.sh

.include <bsd.port.mk>
