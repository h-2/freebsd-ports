# Created by: Ryan Steinmetz <zi@FreeBSD.org>
# $FreeBSD$

PORTNAME=	activerecord-mysql-adapter
PORTVERSION=	0.0.1
CATEGORIES=	databases rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	ActiveRecord adapter for MySQL, based on mysql gem

LICENSE=	MIT

RUN_DEPENDS=	rubygem-activerecord>=3.2.9:${PORTSDIR}/databases/rubygem-activerecord \
		rubygem-activesupport>=3.2.9:${PORTSDIR}/devel/rubygem-activesupport \
		rubygem-mysql>=2.9.0:${PORTSDIR}/databases/rubygem-mysql

USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

.include <bsd.port.mk>
