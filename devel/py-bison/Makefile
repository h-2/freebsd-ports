# Created by: ijliao
# $FreeBSD$

PORTNAME=	bison
PORTVERSION=	0.1.8
PORTREVISION=	4
CATEGORIES=	devel python
MASTER_SITES=	http://freenet.mcnabhosting.com/python/pybison/
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	py${PORTNAME}-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Python-based parsing at the speed of C

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	pyrex>=0.9.6.2:${PORTSDIR}/devel/pyrex

OPTIONS_DEFINE=	DOCS EXAMPLES

USES=		bison:both python
USE_PYTHON=	distutils autoplist

DOCSDIR=	${PREFIX}/share/doc/py-${PORTNAME}
EXAMPLESDIR=	${PREFIX}/share/examples/py-${PORTNAME}

PORTDOCS=	*
PORTEXAMPLES=	*

.include <bsd.port.pre.mk>

.if ${ARCH} == "ia64"
BROKEN=		Does not compile on ia64
.endif

post-install:
	${STRIP_CMD} ${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}/bison_.so
ports-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	@(cd ${WRKSRC}/doc && ${COPYTREE_SHARE} . ${STAGEDIR}${DOCSDIR})
ports-install-EXAMPLES-on:
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	@(cd ${WRKSRC}/examples && ${COPYTREE_SHARE} . ${STAGEDIR}${EXAMPLESDIR})

.include <bsd.port.post.mk>
