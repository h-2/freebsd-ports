# Created by: Alexander Kriventsov <avk@vl.ru>
# $FreeBSD$

PORTNAME=	django-auth-ldap
PORTVERSION=	1.2.7
CATEGORIES=	www security python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	avk@vl.ru
COMMENT=	LDAP integration for django.contrib.auth

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}django18>=1.3.1:${PORTSDIR}/www/py-django18

NO_ARCH=	yes
USES=		python
USE_PYTHON=	autoplist distutils

.include <bsd.port.pre.mk>

.if ${PYTHON_REL} < 3000
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}ldap>0:${PORTSDIR}/net/py-ldap
.else
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}pyldap>0:${PORTSDIR}/net/py-pyldap
.endif

.include <bsd.port.post.mk>
