#############################################################
#
# netperf
#
#############################################################

NETPBM_VERSION = 10.47.63
NETPBM_SOURCE:=netpbm-$(NETPBM_VERSION).tgz

NETPBM_SITE=http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/netpbm/super_stable/$(NETPBM_VERSION)
NETPBM_CONFIGURE_PREFIX=/usr/local
NETPBM_CONFIGURE_EXEC_PREFIX=/usr/local
#NETPBM_INSTALL_STAGING=YES
NETPBM_INSTALL_TARGET=YES

NETPBM_DEPENDENCIES=libpng libxml2

define NETPBM_BUILD_CMDS
   make -C $(@D) CC="${HOSTCC}" buildtools/{endiangen,typegen,libopt}
   make -C $(@D) CC="${TARGET_CC}"
endef

define NETPBM_INSTALL_TARGET_CMDS
	cp $(@D)/converter/other/jpegtopnm $(@D)/converter/other/ppmtopgm $(TARGET_DIR)/usr/local/bin
	cp $(@D)/analyzer/pamfile $(TARGET_DIR)/usr/local/bin/pnmfile
endef

define NETPBM_INSTALL_STAGING_CMDS
endef

define NETPBM_POST_PATCH_CMDS
   sed -e "s^__STAGING_DIR__^$(STAGING_DIR)^g" $(TOPDIR)/package/netpbm/Makefile.config >$(@D)/config.mk
endef
NETPBM_POST_PATCH_HOOKS+=NETPBM_POST_PATCH_CMDS

$(eval $(call GENTARGETS,host))
$(eval $(call GENTARGETS))
