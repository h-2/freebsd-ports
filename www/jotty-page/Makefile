PORTNAME=	jotty-page
DISTVERSION=	1.27.0
CATEGORIES=	www
MASTER_SITES=	https://registry.npmjs.org/@next/swc-wasm-nodejs/-/:swcwasm
DISTFILES=	${SWC_WASM_DISTFILE}:swcwasm

MAINTAINER=	h2+fbsdports@fsfe.org
COMMENT=	Self-hosted notes, checklists and knowledge-base application
WWW=		https://github.com/fccview/jotty

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

# Next.js only lists "x86_64-unknown-freebsd" in its
# knownDefaultWasmFallbackTriples, so only there does it reach for the WASM SWC
# bindings staged below before trying to download a native binding.  aarch64
# would additionally need experimental.useWasmBinary, and several dependencies
# ship no freebsd-arm64 binary at all (@unrs/resolver-binding, @parcel/watcher).
ONLY_FOR_ARCHS=	amd64
ONLY_FOR_ARCHS_REASON=	Next.js and several node dependencies only support freebsd-x64

# yarn (classic, v1) from ports is sufficient; Next.js uses webpack on FreeBSD
# instead of Turbopack (which has no FreeBSD native binary).
# USES=nodejs:24,build,run adds node24 to both BUILD_DEPENDS and RUN_DEPENDS.
#
# USES=npm:yarn1 makes the framework populate a yarn offline mirror during the
# *fetch* phase -- the only phase where poudriere and the official build
# cluster allow network access -- from the copies of package.json and yarn.lock
# kept in ${FILESDIR}/packagejsons, archive it into the
# jotty-page-${DISTVERSION}-node-modules.tar.gz distfile, and then run
# "yarn install --offline" during the extract phase.  As a result node_modules/
# is fully populated before do-build starts and the build itself needs no
# network at all.  It also adds yarn to FETCH_/EXTRACT_/BUILD_DEPENDS.
#
# NOTE: the two files under ${FILESDIR}/packagejsons must be kept in sync with
# the ones in the distfile on every version bump, otherwise the prefetched
# modules and the source tree disagree.
USES=		nodejs:24,build,run npm:yarn1,build

USE_GITHUB=	yes
GH_ACCOUNT=	fccview
GH_PROJECT=	jotty

USE_RC_SUBR=	jotty_page

JOTTYPAGE_USER?=	www
JOTTYPAGE_GROUP?=	www

USERS=		${JOTTYPAGE_USER}
GROUPS=		${JOTTYPAGE_GROUP}

# Build-time environment --------------------------------------------------
# NOTE: NODE_ENV must NOT be set to "production" here, because MAKE_ENV is
# also what USES=npm passes to its "yarn install" invocations and yarn 1.x
# silently skips devDependencies when NODE_ENV=production.  The build toolchain
# (Next.js, Tailwind, @serwist/turbopack, …) lives in devDeps.
# NODE_ENV=production is set explicitly only for the patch and build steps.

# Derive a stable, per-version AES-256 key for NEXT_SERVER_ACTIONS_ENCRYPTION_KEY.
# Without this, Next.js calls crypto.subtle.generateKey() on every build, producing
# a fresh random key that is baked into every server action ID.  Different keys →
# different action IDs → different module content → different chunk content-hashes →
# different filenames in .next/static/chunks, making pkg-plist unstable.
# The key must be base64(32 bytes); SHA-256 of "portname-version" satisfies that.
#
# The command lives in its own variable and is evaluated through the :sh
# modifier, so the shell runs only when MAKE_ENV is expanded by a do-build
# recipe line, not while the Makefile is parsed.  Metadata invocations
# ("make -V", INDEX builds) therefore fork nothing at all.  Deferring also means
# ${PRINTF} is already defined by the time it is expanded; with a parse-time
# assignment it would still be empty, silently hashing an empty string.
#
# Note that :sh re-evaluates on every expansion; that is only safe because the
# derivation is deterministic and yields an identical key each time.  Do not
# switch it to a random source, or each recipe line would get a different key
# and the unstable pkg-plist described above would return.
_JOTTYPAGE_ACTION_KEY_CMD=	${PRINTF} '%s' '${PORTNAME}-${DISTVERSION}' | \
				/usr/bin/openssl dgst -sha256 -binary | \
				/usr/bin/openssl enc -base64 -A
_JOTTYPAGE_ACTION_KEY=		${_JOTTYPAGE_ACTION_KEY_CMD:sh}

MAKE_ENV+=	JOTTY_FREEBSD=1 \
		JOTTY_BODY_SIZE_LIMIT=100mb \
		NEXT_TELEMETRY_DISABLED=1 \
		HOME=${WRKDIR} \
		YARN_CACHE_FOLDER=${WRKDIR}/.yarn-cache \
		NEXT_SERVER_ACTIONS_ENCRYPTION_KEY=${_JOTTYPAGE_ACTION_KEY}

SUB_FILES=	jotty_page pkg-message
SUB_LIST+=	JOTTYPAGE_USER=${JOTTYPAGE_USER} \
		JOTTYPAGE_GROUP=${JOTTYPAGE_GROUP} \
		PREFIX=${PREFIX} \
		DATADIR=${DATADIR}

PLIST_SUB+=	JOTTYPAGE_USER=${JOTTYPAGE_USER} \
		JOTTYPAGE_GROUP=${JOTTYPAGE_GROUP}

# Next.js SWC bindings ----------------------------------------------------
# There is no @next/swc-freebsd-* native binding, so next/dist/build/swc uses
# the WASM build instead; "x86_64-unknown-freebsd" is in that module's
# knownDefaultWasmFallbackTriples, so it is tried before any native binding.
# Next.js then *downloads* @next/swc-wasm-nodejs from the npm registry
# ("Downloading swc package @next/swc-wasm-nodejs...") in the middle of
# do-build, which a sandboxed build cannot do.  Fetch it as an ordinary
# distfile instead.  Keep the version in sync with "next" in package.json.
#
# Note that installing the package into node_modules does NOT help: the
# node_modules branch of loadWasmRawBindings() runs the bare specifier through
# pathToFileURL(), which turns it into a path relative to the current working
# directory rather than resolving it, so it can never match.  What does work is
# next/dist/lib/download-swc.js: downloadWasmSwc() returns without touching the
# network as soon as its output directory exists, and loadWasm() then imports
# wasm.js straight out of it.  So we simply create that directory ourselves.
SWC_WASM_VERSION=	16.3.0
SWC_WASM_DISTFILE=	swc-wasm-nodejs-${SWC_WASM_VERSION}.tgz
_SWC_WASM_DIR=		${WRKSRC}/node_modules/next/wasm/@next/swc-wasm-nodejs

# post-extract runs at priority 700, i.e. after USES=npm has populated
# node_modules at 602, and does two things:
#
#   1. Stage the WASM SWC bindings.  npm tarballs always unpack to a top-level
#      "package" directory and do-extract unpacks every distfile into
#      ${WRKDIR}, so moving it into place is all that is needed.
#   2. Remove what USES=npm left behind in ${WRKSRC}: the offline mirror and
#      its .yarnrc, plus the originals npm-copy-package-file replaced and kept
#      as *.bak.  Next.js copies the whole project root into .next/standalone/,
#      so all of that would otherwise end up in the package -- the mirror alone
#      is some 865MB.  Nothing needs them any more at this point: the only
#      "yarn install" this port runs has already happened, during extract.
post-extract:
	@${RM} -r ${_SWC_WASM_DIR}
	@${MKDIR} ${_SWC_WASM_DIR:H}
	@${MV} ${WRKDIR}/package ${_SWC_WASM_DIR}
	@${RM} -r ${WRKSRC}/yarn-offline-cache ${WRKSRC}/.yarnrc \
		${WRKSRC}/package.json.bak ${WRKSRC}/yarn.lock.bak

# do-build ----------------------------------------------------------------
# Steps mirror the Docker builder stage, except that the dependency install
# already happened during the extract phase (USES=npm, see above).
#   1. Apply FreeBSD compatibility patches to node_modules.
#   2. Build the Next.js application (produces .next/standalone/).
#   3. Populate the standalone directory with static and public assets.
#   4. Stage scripts, patches, config and docs inside standalone so a single
#      COPYTREE_SHARE in do-install captures everything.
#   5. Apply all patches to the standalone node_modules at build time so the
#      installed tree is ready to run without requiring write access at
#      startup.
do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} NODE_ENV=production node scripts/apply-patches.js
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} NODE_ENV=production yarn build
	${CP} -rp ${WRKSRC}/.next/static ${WRKSRC}/.next/standalone/.next/
	${CP} -rp ${WRKSRC}/public ${WRKSRC}/.next/standalone/
	${MKDIR} ${WRKSRC}/.next/standalone/scripts \
		${WRKSRC}/.next/standalone/patches \
		${WRKSRC}/.next/standalone/user_patches
	${CP} ${WRKSRC}/scripts/apply-patches.js \
		${WRKSRC}/.next/standalone/scripts/
	(cd ${WRKSRC}/patches && ${COPYTREE_SHARE} . \
		${WRKSRC}/.next/standalone/patches)
	cd ${WRKSRC}/.next/standalone && \
		${SETENV} ${MAKE_ENV} NODE_ENV=production node scripts/apply-patches.js
	(cd ${WRKSRC}/howto && ${COPYTREE_SHARE} . \
		${WRKSRC}/.next/standalone/howto)
	(cd ${WRKSRC}/config && ${COPYTREE_SHARE} . \
		${WRKSRC}/.next/standalone/config)

# do-install --------------------------------------------------------------
# Install the self-contained standalone directory to DATADIR.
# User-writable data lives in /var/db/jotty-page, created by rc-script later on
# and accessed via a (dangling) symlink we create now.
do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	(cd ${WRKSRC}/.next/standalone && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR})
	${LN} -sf /var/db/jotty-page ${STAGEDIR}${DATADIR}/data
	${INSTALL_DATA} ${FILESDIR}/jotty-page.env.sample \
		${STAGEDIR}${PREFIX}/etc/jotty-page.env.sample

# Maintainer helper -------------------------------------------------------
# Regenerate pkg-plist in one step:  make regen-plist
#
# "make makeplist" deliberately pretends pkg-plist was empty and lists the
# whole STAGEDIR, so its output also contains the rc script -- but USE_RC_SUBR
# appends that to the plist on its own (install-rc-script in bsd.port.mk).
# Keeping both entries makes check-plist report the file as Missing, because
# the single staged file only ever satisfies the first of the two.  The first
# output line is makeplist's "check what this gives you" marker.
#
# check-stagedir.sh is invoked exactly the way the makeplist target does it,
# so stdout carries only that marker plus the plist itself.
regen-plist: stage
	@${SETENV} ${CO_ENV} ${SH} ${SCRIPTSDIR}/check-stagedir.sh makeplist | \
		${SED} -e 1d -e '\|^etc/rc\.d/${USE_RC_SUBR}$$|d' \
		> ${.CURDIR}/pkg-plist
	@${ECHO_MSG} "===>  Wrote ${.CURDIR}/pkg-plist"

.include <bsd.port.mk>
