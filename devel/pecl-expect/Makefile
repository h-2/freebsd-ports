# Created by: chinsan <chinsan.tw@gmail.com>
# $FreeBSD$

PORTNAME=	expect
PORTVERSION=	0.3.3
CATEGORIES=	devel pear
MASTER_SITES=	http://pecl.php.net/get/
PKGNAMEPREFIX=	pecl-
DIST_SUBDIR=	PECL

MAINTAINER=	miwi@FreeBSD.org
COMMENT=	PHP extension for expect library

LICENSE=	PHP301

LIB_DEPENDS=	libexpect.so:${PORTSDIR}/lang/expect

USES=		tar:tgz tcl:86
USE_PHP=	yes
USE_PHPEXT=	yes

CFLAGS+=	-I${TCL_INCLUDEDIR}
CONFIGURE_ARGS+=--with-expect=${LOCALBASE}

.include <bsd.port.mk>
