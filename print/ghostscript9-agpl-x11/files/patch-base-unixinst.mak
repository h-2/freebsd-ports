--- base/unixinst.mak.orig	2014-03-26 21:53:47.000000000 +0900
+++ base/unixinst.mak	2014-11-23 17:01:40.000000000 +0900
@@ -45,7 +45,7 @@
 wftopfa fixmswrd.pl lprsetup.sh pj-gs.sh pv.sh sysvlp.sh unix-lpr.sh ;\
 	do if ( test -f $(PSLIBDIR)/$$f ); then \
 	  (cat $(PSLIBDIR)/$$f | sed -e "s/GS_EXECUTABLE=gs/GS_EXECUTABLE=$(GS)/" > $(PSOBJDIR)/$$f); \
-	  $(INSTALL_PROGRAM) $(PSOBJDIR)/$$f $(DESTDIR)$(scriptdir)/$$f; \
+	  $(INSTALL_SCRIPT) $(PSOBJDIR)/$$f $(DESTDIR)$(scriptdir)/$$f; \
 	fi;\
 	done'
 
@@ -142,7 +142,7 @@
 	done'
 
 # install the man pages for each locale
-MAN_LCDIRS=. de
+MAN_LCDIRS=.
 MAN1_LINKS_PS2PS=eps2eps
 MAN1_LINKS_PS2PDF=ps2pdf12 ps2pdf13 ps2pdf14
 MAN1_LINKS_GSLP=gsbj gsdj gsdj500 gslj
