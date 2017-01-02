####
#
# cfitsio package
#
####

CFITSIO_VERSION = 3390
CFITSIO_SOURCE=cfitsio$(CFITSIO_VERSION).tar.gz
CFITSIO_LICENSE = Unknown
CFITSIO_SITE=http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c
#
# For libraries this would be YES
# 
CFITSIO_INSTALL_STAGING = YES

#
# Install to target
#
CFITSIO_INSTALL_TARGET = NO

$(eval $(call AUTOTARGETS))


