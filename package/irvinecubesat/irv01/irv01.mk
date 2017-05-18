####
#
# Irvine 01 cubesat software package.  
#
####

IRV01_VERSION = 0.0
IRV01_SOURCE=irvine-01-sw-$(IRV01_VERSION).tar.gz
IRV01_SITE=https://github.com/irvinecubesat/irvine-01-sw
IRV01_SITE_METHOD=git
IRV01_SUPPORTS_IN_SOURCE_BUILD = NO
IRV01_CONF_OPT=-DWITH_BUILDROOT=ON
#
# For libraries this would be YES
#
IRV01_INSTALL_STAGING = NO

#
# Install to target
#
IRV01_INSTALL_TARGET = YES

IRV01_DEPENDENCIES=i2c-tools polysat_fsw

ifeq ($(BR2_PACKAGE_IRV01_version_custom),y)
	IRV01_VERSION=$(subst ",,$(BR2_PACKAGE_IRV01_CONFIG_CUSTOM_VERSION_STR))
endif

ifeq ($(BR2_PACKAGE_IRV01_version_head),y)
   IRV01_VERSION:=$(shell git ls-remote $(IRV01_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
endif

$(eval $(cmake-package))

$(eval $(call CMAKETARGETS,package,irv01))
