# $FreeBSD$

PORTNAME?=	mariadb
PORTVERSION=	10.1.11
CATEGORIES=	databases ipv6
MASTER_SITES=	http://ftp.osuosl.org/pub/${SITESDIR}/ \
		http://mirrors.supportex.net/${SITESDIR}/ \
		http://mirror2.hs-esslingen.de/pub/Mirrors/${SITESDIR}/ \
		http://gd.tuwien.ac.at/db/${SITESDIR}/ \
		http://mirrors.fe.up.pt/pub/${SITESDIR}/ \
		http://mirror.de.gsnw.de:56431/${SITESDIR}/ \
		http://mirror.layerjet.com/${SITESDIR}/ \
		http://mirror.switch.ch/mirror/${SITESDIR}/
PKGNAMESUFFIX?=	101-server

MAINTAINER=	brnrd@FreeBSD.org
COMMENT?=	Multithreaded SQL database (server)

LICENSE=	GPLv2

SUB_FILES=	pkg-message
PKGMESSAGE=	${WRKDIR}/pkg-message

SLAVEDIRS=	databases/mariadb101-client
USES=		bison:build cmake cpe execinfo shebangfix
USE_LDCONFIG=	${PREFIX}/lib/mysql
SHEBANG_FILES=	scripts/*.sh
SITESDIR=	mariadb/mariadb-${PORTVERSION}/source

OPTIONS_DEFINE=		FASTMTX
OPTIONS_SINGLE= 	GSSAPI
OPTIONS_SINGLE_GSSAPI=	GSSAPI_BASE GSSAPI_HEIMDAL GSSAPI_MIT
OPTIONS_DEFAULT=	GSSAPI_BASE

FASTMTX_DESC=		Replace mutexes with spinlocks

.if !defined(CLIENT_ONLY)
# MySQL-Server options
OPTIONS_DEFINE+=	MAXKEY
OPTIONS_DEFAULT+=	MAXKEY SPHINX SPIDER
OPTIONS_GROUP=		ENGINES
OPTIONS_GROUP_ENGINES=	INNOBASE MROONGA OQGRAPH SPHINX SPIDER TOKUDB

ENGINES_DESC=	Optional MariaDB storage engines
INNOBASE_DESC=	Build InnoDB engine next to XtraDB
MAXKEY_DESC=	Change max key length from 1000 to 4000
MROONGA_DESC=	Mroonga Full Text Search engine
OQGRAPH_DESC=	Open Query Graph Computation engine (Requires GCC)
SPHINX_DESC=	SphinxSE engine
SPIDER_DESC=	Partitioning and XA-transactions engine
TOKUDB_DESC=	Fractal tree index tree data structure engine
.endif

GSSAPI_BASE_USES=	gssapi
GSSAPI_HEIMDAL_USES=	gssapi:heimdal
GSSAPI_MIT_USES=	gssapi:mit

CMAKE_ARGS+=	-DINSTALL_DOCDIR="share/doc/mysql" \
		-DINSTALL_DOCREADMEDIR="share/doc/mysql" \
		-DINSTALL_INCLUDEDIR="include/mysql" \
		-DINSTALL_INFODIR="info" \
		-DINSTALL_LIBDIR="lib/mysql" \
		-DINSTALL_MANDIR="man" \
		-DINSTALL_MYSQLDATADIR="/var/db/mysql" \
		-DINSTALL_MYSQLSHAREDIR="share/mysql" \
		-DINSTALL_MYSQLTESTDIR= \
		-DINSTALL_PLUGINDIR="lib/mysql/plugin" \
		-DINSTALL_SBINDIR="libexec" \
		-DINSTALL_SCRIPTDIR="bin" \
		-DINSTALL_SHAREDIR="share" \
		-DINSTALL_SQLBENCHDIR= \
		-DINSTALL_SUPPORTFILESDIR="share/mysql" \
		-DWITH_UNIT_TESTS=0 \
		-DWITH_LIBWRAP=1 \
		-DWITH_SSL=${OPENSSLBASE} \
		-DKRB5_CONFIG=${KRB5CONFIG} \
		-DEXECINFO_ROOT=${LOCALBASE} \
		-DCOMPILATION_COMMENT="FreeBSD Ports"

DATADIR=	${PREFIX}/share/mysql

.ifdef USE_MYSQL
.error You have `USE_MYSQL' variable defined either in environment or in make(1) arguments. This leads to a circular dependency. Please undefine and try again.
.endif

CONFLICTS_INSTALL=	mariadb5*-${PKGNAMESUFFIX:C/^[0-9]*-//}-* \
			mariadb10[02-9]-${PKGNAMESUFFIX:C/^[0-9]*-//}-* \
			mysql[0-9]*-${PKGNAMESUFFIX:C/^[0-9]*-//}-* \
			percona[0-9]*-${PKGNAMESUFFIX:C/^[0-9]*-//}-*

USE_OPENSSL=		yes
FASTMTX_CMAKE_ON=	-DWITH_FAST_MUTEXES=1

.if defined(CLIENT_ONLY)
# MySQL-Client part
USES+=		readline
.else
# MySQL-Server part
USE_MYSQL=	yes
WANT_MYSQL_VER=	101m
OPTIONS_SUB=	yes
USE_LDCONFIG+=	${PREFIX}/lib/mysql/plugin
USE_RC_SUBR=	mysql-server
USERS=		mysql
GROUPS=		mysql
CMAKE_ARGS+=	-DWITH_EMBEDDED_SERVER="ON" \
		-DCMAKE_SKIP_BUILD_RPATH:BOOL=YES \
		-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1

.for ENGINE in ${OPTIONS_GROUP_ENGINES}
${ENGINE}_CMAKE_OFF=	-DWITHOUT_${ENGINE}=1
.endfor

MAXKEY_EXTRA_PATCHES+=	${FILESDIR}/extra-patch-include_my__compare.h
OQGRAPH_LIB_DEPENDS=	libboost_system.so:${PORTSDIR}/devel/boost-libs \
			libJudy.so:${PORTSDIR}/devel/judy
# Currently OQGraph does not build using clang.
# See See https://mariadb.atlassian.net/browse/MDEV-8051.
OQGRAPH_USE=		gcc=yes
TOKUDB_LIB_DEPENDS=	libsnappy.so:${PORTSDIR}/archivers/snappy

post-install:
# Remove programs to avoid conflict with mariadb101-client
# These are "client" components, so there should be a switch that
# prevents them from being installed but it's unknown right now
	${RM} ${STAGEDIR}${PREFIX}/bin/msql2mysql \
		${STAGEDIR}${PREFIX}/bin/mysql_config \
		${STAGEDIR}${PREFIX}/bin/mysql_find_rows \
		${STAGEDIR}${PREFIX}/bin/mysqlaccess
	${RM} -r ${STAGEDIR}/${PREFIX}/share/mysql/policy \
		${STAGEDIR}/${PREFIX}/share/pkgconfig
# See https://mariadb.atlassian.net/browse/MDEV-9529
	${RM} ${STAGEDIR}/${PREFIX}/bin/maria_add_gis_sp.sql
.endif # defined(CLIENT_ONLY)

.include <bsd.port.options.mk>

.if defined(WITH_OPENSSL_PORT) && ${PORT_OPTIONS:MGSSAPI_BASE}
IGNORE=	GSSAPI_BASE is not compatible with OpenSSL from ports. Use other GSSAPI options or OpenSSL from base system
.endif

.include <bsd.port.pre.mk>

.if ${OPSYS} == DragonFly
CMAKE_ARGS+=	-DWITHOUT_TOKUDB
.endif

.if ${OPSYS} == FreeBSD && ${OSVERSION} >= 1000012
CMAKE_ARGS+=	-DWITH_JEMALLOC="system"
.else
CMAKE_ARGS+=	-DWITH_JEMALLOC="no"
.endif

post-patch:
	@${REINPLACE_CMD} 's/*.1/${MAN1}/' ${WRKSRC}/man/CMakeLists.txt
	@${REINPLACE_CMD} 's|%%PREFIX%%|${PREFIX}|g' ${WRKSRC}/mysys/my_default.c
	@${REINPLACE_CMD} 's|%%LOCALBASE%%|${LOCALBASE}|g' ${WRKSRC}/scripts/mysql_config.sh
.if ${OPSYS} == DragonFly
	${CP} ${WRKSRC}/cmake/os/FreeBSD.cmake \
		${WRKSRC}/cmake/os/DragonFly.cmake
.endif

.include <bsd.port.post.mk>
