# Created by: Sunpoet Po-Chuan Hsieh <sunpoet@FreeBSD.org>
# $FreeBSD$

PORTNAME=	fog-core
PORTVERSION=	1.35.0
CATEGORIES=	devel rubygems
MASTER_SITES=	RG

MAINTAINER=	sunpoet@FreeBSD.org
COMMENT=	Shared classes and tests for fog providers and services

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.md

RUN_DEPENDS=	rubygem-builder32>=0:${PORTSDIR}/devel/rubygem-builder32 \
		rubygem-excon>=0.45:${PORTSDIR}/devel/rubygem-excon \
		rubygem-formatador>=0.2:${PORTSDIR}/devel/rubygem-formatador

NO_ARCH=	yes
USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

.include <bsd.port.mk>
