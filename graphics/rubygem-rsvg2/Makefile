# $FreeBSD$

PORTNAME=	rsvg2
PORTVERSION=	3.0.7
PORTREVISION=	1
CATEGORIES=	graphics rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Ruby binding for librsvg2

LICENSE=	LGPL21+

RUN_DEPENDS=	rubygem-cairo>=1.12.8:${PORTSDIR}/graphics/rubygem-cairo \
		rubygem-gdk_pixbuf2>=${PORTVERSION}:${PORTSDIR}/graphics/rubygem-gdk_pixbuf2

USE_GNOME=	librsvg2
USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

.include <bsd.port.mk>
