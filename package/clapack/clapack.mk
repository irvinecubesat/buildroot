####
#
# clapack
#
####

CLAPACK_VERSION = 3.2.1
CLAPACK_SOURCE=clapack-3.2.1-CMAKE.tgz
CLAPACK_SITE=http://www.netlib.org/clapack/clapack-3.2.1-CMAKE.tgz
CLAPACK_SUPPORTS_IN_SOURCE_BUILD = NO
#CLAPACK_CONF_OPT=-DWITH_BUILDROOT=ON
#
# For libraries this would be YES
#
CLAPACK_INSTALL_STAGING = YES

#
# Install to target
#
CLAPACK_INSTALL_TARGET = YES

CLAPACK_DEPENDENCIES=
CLAPACK_CONF_OPTS=$(TARGET_CONFIGURE_OPTS)

ifneq ($(BR2_PACKAGE_CLAPACK_ARITH_H),)
CLAPACK_CONF_OPTS += -DARITH_H=$(BR2_PACKAGE_CLAPACK_ARITH_H) 
endif

$(eval $(cmake-package))

$(eval $(call CMAKETARGETS,package,clapack,host))
$(eval $(call CMAKETARGETS,package,clapack))
