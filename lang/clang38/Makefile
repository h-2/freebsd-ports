# Created by: Brooks Davis
# $FreeBSD$

PORTNAME=	clang
PORTVERSION=	3.8
PORTREVISION=	1
CATEGORIES=	lang devel
PKGNAMESUFFIX=	${LLVM_SUFFIX}

MAINTAINER=	brooks@FreeBSD.org
COMMENT=	C, Objective-C, and C++ compiler (use devel/llvm${LLVM_SUFFIX})

RUN_DEPENDS+=	${LOCALBASE}/bin/clang${LLVM_SUFFIX}:${PORTSDIR}/devel/llvm${LLVM_SUFFIX}

LLVM_SUFFIX=	38

USES=		metaport

.include <bsd.port.mk>
