#############################################################
#
# openocd
#
#############################################################
#
# mcli fix - lcm source relocated to github and packaged as zip
#
# Old address:  https://lcm.googlecode.com/files/lcm-1.0.0.tar.gz
# New address:  https://github.com/lcm-proj/lcm/releases/download/v1.0.0/lcm-1.0.0.zip
#
# Top level Makefile modified to download zip file and repackage as tgz
#
LCM_VERSION:=1.0.0
LCM_SOURCE = lcm-$(LCM_VERSION).tgz
LCM_SITE = https://github.com/lcm-proj/lcm/releases/download/v$(LCM_VERSION)

#LCM_AUTORECONF = YES
#LCM_DEPENDENCIES =

HOST_LCM_DEPENDENCIES = host-libglib2
LCM_ST_HEADERS=$(STAGING_DIR)/usr/include/lcm
LCM_PKG_DIR=lcm

define LCM_INSTALL_STAGING_CMDS
endef

define LCM_INSTALL_TARGET_CMDS
endef

define HOST_LCM_INSTALL_CMDS
        $(MAKE1) -C $(@D) install
	mkdir -p $(LCM_ST_HEADERS)
	cp -f $(@D)/$(LCM_PKG_DIR)/eventlog.h $(@D)/$(LCM_PKG_DIR)/lcm_coretypes.h $(@D)/$(LCM_PKG_DIR)/lcm-cpp.hpp $(@D)/$(LCM_PKG_DIR)/lcm-cpp-impl.hpp $(@D)/$(LCM_PKG_DIR)/lcm.h $(LCM_ST_HEADERS)
endef


#$(eval $(call AUTOTARGETS))
$(eval $(call AUTOTARGETS,host))
