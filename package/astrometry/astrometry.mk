####
#
# Astrometry package
#
####

ASTROMETRY_VERSION = 0.67
ASTROMETRY_SOURCE=astrometry-$(ASTROMETRY_VERSION).tar.gz
ASTROMETRY_LICENSE = Unknown
ASTROMETRY_SITE=https://github.com/dstndstn/astrometry.net
ASTROMETRY_SITE_METHOD=git

#ASTROMETRY_CONF_OPT=-DWITH_BUILDROOT=ON
#
# For libraries this would be YES
#
ASTROMETRY_INSTALL_STAGING = NO

#
# Install to target
#
ASTROMETRY_INSTALL_TARGET = YES

ASTROMETRY_DEPENDENCIES=cfitsio zlib

ifeq ($(BR2_PACKAGE_ASTROMETRY_version_custom),y)
	ASTROMETRY_VERSION=$(subst ",,$(BR2_PACKAGE_ASTROMETRY_CONFIG_CUSTOM_VERSION_STR))
endif

ifeq ($(BR2_PACKAGE_ASTROMETRY_version_head),y)
   ASTROMETRY_VERSION:=$(shell git ls-remote $(ASTROMETRY_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
endif

#CFLAGS="-g -Wall  -pthread -march=armv5 -O3 -fomit-frame-pointer -DNDEBUG -fpic -Winline -I../include -I../include/astrometry -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -I. -I../include -I../gsl-an -I../include/astrometry" LDFLAGS="-lpthread" 
define ASTROMETRY_BUILD_CMDS
export CC="${TARGET_CC}";$(MAKE) ARCH_FLAGS="-march=armv5" CC="${TARGET_CC}" CFITS_INC="-I$(STAGING_DIR)/usr/include" CFITS_LIB="-L../../cfitsio-3390/ -lcfitsio -lpthread" -C $(@D)
endef

define ASTROMETRY_INSTALL_TARGET_CMDS
	touch $(@D)/report.txt
export CC="${TARGET_CC}";$(MAKE) ARCH_FLAGS="-march=armv5" CC="${TARGET_CC}" CFITS_INC="-I$(STAGING_DIR)/usr/include" CFITS_LIB="-L../../cfitsio-3390/ -lcfitsio -lpthread" INSTALL_DIR=$(TARGET_DIR)/usr/local -C $(@D) install-minimal-solve
#	$(MAKE) INSTALL_DIR=$(TARGET_DIR) -C $(@D) install-core
endef
$(eval $(GENTARGETS))
