# $FreeBSD$

PORTNAME=	emot
PORTVERSION=	0.0.4
CATEGORIES=	textproc rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Yet another emoji handler

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

RUN_DEPENDS=	rubygem-thor>=0:${PORTSDIR}/devel/rubygem-thor

NO_ARCH=	yes

USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

PLIST_FILES=	bin/emot

.include <bsd.port.mk>
