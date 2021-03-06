# Created by: Brendan Molloy <brendan+freebsd@bbqsrc.net>
# $FreeBSD$

PORTNAME=	mongodb32
PORTVERSION=	3.2.1
DISTVERSIONPREFIX=	r
PORTREVISION=	1
CATEGORIES=	databases net
MASTER_SITES=	https://fastdl.mongodb.org/src/ \
		http://fastdl.mongodb.org/src/ \
		http://download.mongodb.org/src/
DISTNAME=	mongodb-src-${DISTVERSIONPREFIX}${PORTVERSION}

MAINTAINER=	brendan+freebsd@bbqsrc.net
COMMENT=	Distributed document-oriented "NoSQL" database

# mongodb is AGPLv3, C++ driver is APACHE20
LICENSE=	AGPLv3 APACHE20
LICENSE_COMB=	multi

LIB_DEPENDS=	libpcre.so:${PORTSDIR}/devel/pcre \
		libsnappy.so:${PORTSDIR}/archivers/snappy
TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}yaml>=3.11:${PORTSDIR}/devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}pymongo>=3.0:${PORTSDIR}/databases/pymongo

ONLY_FOR_ARCHS=	i386 amd64
ONLY_FOR_ARCHS_REASON=	"not yet ported to anything other than i386 and amd64"

OPTIONS_DEFINE=		SASL SSL WIREDTIGER
OPTIONS_DEFAULT=	SSL WIREDTIGER

# Only supported on 64-bit
OPTIONS_EXCLUDE_i386=	WIREDTIGER

SASL_LIB_DEPENDS=	libsasl2.so:${PORTSDIR}/security/cyrus-sasl2
SASL_MAKE_ARGS=		--use-sasl-client

SSL_USE=	openssl=yes
SSL_MAKE_ARGS=	--ssl

WIREDTIGER_DESC=	WiredTiger database engine support
WIREDTIGER_VARS=	wiredtiger_build=on
WIREDTIGER_VARS_OFF=	wiredtiger_build=off

USES=		cpe execinfo python:build scons

MAKE_ARGS=	--prefix=${STAGEDIR}${PREFIX} \
		--wiredtiger=${WIREDTIGER_BUILD} \
		--use-system-pcre --use-system-snappy \
		--release

USERS=	mongodb
GROUPS=	mongodb

USE_RC_SUBR=	mongod

ALL_TARGET=	core
TEST_TARGET=	unittests

.include <bsd.port.pre.mk>

.if ${ARCH} == "i386"
WIREDTIGER_BUILD=	off
.endif

.if ${OSVERSION} < 1000000
# Cannot be built
IGNORE=	unsupported on FreeBSD 9 or older
.endif

post-install:
.for f in mongo mongod mongoperf mongos mongosniff
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/${f}
.endfor

do-test:
	@cd ${BUILD_WRKSRC} && ${SETENV} ${MAKE_ENV} \
		${MAKE_CMD} ${_MAKE_JOBS} ${MAKE_ARGS} ${TEST_TARGET} &&\
		${PYTHON_CMD} ${BUILD_WRKSRC}/buildscripts/resmoke.py\
		--suites=unittests --jobs=${MAKE_JOBS_NUMBER}

PORTSCOUT=	limitw:1,even

CPE_PRODUCT=	mongodb

.include <bsd.port.post.mk>
