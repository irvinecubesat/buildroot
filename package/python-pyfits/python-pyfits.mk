################################################################################
#
# python-pyfits
#
################################################################################

PYTHON_PYFITS_VERSION = 3.4
PYTHON_PYFITS_SOURCE = pyfits-$(PYTHON_PYFITS_VERSION).tar.gz
PYTHON_PYFITS_SITE = https://pypi.python.org/packages/45/98/d6d25932e6a82fa8456d38ab307bfb8945a1e1dd4e896730555e3b61cfc5
PYTHON_PYFITS_LICENSE = BSD-3c
PYTHON_PYFITS_LICENSE_FILES = LICENSE.txt
PYTHON_PYFITS_SETUP_TYPE = distutils

PYTHON_PYFITS_DEPENDENCIES=host-python-setuptools python-numpy host-python-numpy zlib

define PYTHON_PYFITS_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_PYFITS_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef


# Some package may include few headers from Pyfits, so let's install it
# in the staging area.
PYTHON_PYFITS_INSTALL_STAGING = YES

$(eval $(call GENTARGETS))

