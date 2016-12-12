################################################################################
#
# python-numpy
#
################################################################################

PYTHON_NUMPY_VERSION = 1.8.0
PYTHON_NUMPY_SOURCE = numpy-$(PYTHON_NUMPY_VERSION).tar.gz
PYTHON_NUMPY_SITE = http://downloads.sourceforge.net/numpy
PYTHON_NUMPY_LICENSE = BSD-3c
PYTHON_NUMPY_LICENSE_FILES = LICENSE.txt
PYTHON_NUMPY_SETUP_TYPE = distutils
PYTHON_NUMPY_DEPENDENCIES= python host-python
ifeq ($(BR2_PACKAGE_CLAPACK),y)
PYTHON_NUMPY_DEPENDENCIES += clapack
PYTHON_NUMPY_SITE_CFG_LIBS += blas lapack
endif

PYTHON_NUMPY_BUILD_OPTS = --fcompiler=None

define PYTHON_NUMPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_NUMPY_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef

define HOST_PYTHON_NUMPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(HOST)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(HOST)/usr/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_NUMPY_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef


define PYTHON_NUMPY_BUILD_CMDS
	(cd $(@D); CC="$(TARGET_CC)" CFLAGS="-z text  $(TARGET_CFLAGS)" \
		LDSHARED="$(TARGET_CROSS)gcc -shared " \
		CROSS_COMPILING=yes \
		_python_sysroot=/opt/toolchain/toolchain-arm-linux/arm-unknown-linux-uclibcgnueabi/sysroot/\
		_python_srcdir=$(BUILD_DIR)/python$(PYTHON_VERSION) \
		_python_prefix=/usr/local \
		_python_exec_prefix=/usr/local \
		$(HOST_DIR)/usr/bin/python setup.py build --fcompiler=/opt/toolchain/toolchain-arm-linux/arm-unknown-linux-uclibcgnueabi/bin/gfortran)
endef

define HOST_PYTHON_NUMPY_BUILD_CMDS
	(cd $(@D); CC="$(HOSTCC)" CFLAGS="-z text  $(HOST_CFLAGS)" \
		LDSHARED="$(HOSTCC) -shared " \
		_python_srcdir=$(BUILD_DIR)/python$(PYTHON_VERSION) \
		_python_prefix=/usr/ \
		_python_exec_prefix=/usr/ \
		$(HOST_DIR)/usr/bin/python setup.py	build )
endef

define PYTHON_NUMPY_INSTALL_TARGET_CMDS
	(cd $(@D); PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages \
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr/local)
endef

define HOST_PYTHON_NUMPY_INSTALL_CMDS
	(cd $(@D); PYTHONPATH=$(HOST_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages \
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(HOST_DIR)/usr)
endef
# Some package may include few headers from NumPy, so let's install it
# in the staging area.
PYTHON_NUMPY_INSTALL_STAGING = YES

$(eval $(call GENTARGETS))
$(eval $(call GENTARGETS,host))

