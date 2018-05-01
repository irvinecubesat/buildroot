#############################################################
#
# python-setuptools
#
#############################################################

PYTHON_STSCI_DISTUTILS_VERSION = 0.3.7
PYTHON_STSCI_DISTUTILS_SOURCE  = stsci.distutils-$(PYTHON_STSCI_DISTUTILS_VERSION).tar.gz
PYTHON_STSCI_DISTUTILS_SITE    = https://files.pythonhosted.org/packages/f7/ec/c389250a555ab8429ca91becaf2a22948fd2d0952d693b99b34cad8ecf08
#http://pypi.python.org/packages/source/s/setuptools
PYTHON_STSCI_DISTUTILS_DEPENDENCIES = python python-d2to1 host-python-d2to1

define HOST_PYTHON_STSCI_DISTUTILS_BUILD_CMDS				
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py build)
endef

define PYTHON_STSCI_DISTUTILS_BUILD_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py build)
endef

define HOST_PYTHON_STSCI_DISTUTILS_INSTALL_CMDS
	(cd $(@D); PYTHONPATH="$(HOST_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages"\
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(HOST_DIR)/usr)
endef

define PYTHON_STSCI_DISTUTILS_INSTALL_TARGET_CMDS
	(cd $(@D); PYTHONPATH="$(TARGET_DIR)/usr/local/lib/python$(PYTHON_VERSION_MAJOR)/site-packages"\
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr/local)
endef

$(eval $(call GENTARGETS))
$(eval $(call GENTARGETS,host))

