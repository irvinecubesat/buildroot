#############################################################
#
# python-setuptools
#
#############################################################

PYTHON_D2TO1_VERSION = 0.2.12.post1
PYTHON_D2TO1_SOURCE  = d2to1-$(PYTHON_D2TO1_VERSION).tar.gz
PYTHON_D2TO1_SITE    = https://files.pythonhosted.org/packages/dc/bd/eac45e4e77d76f6c0ae539819c40f1babb891d7855129663e37957a7c2df
#http://pypi.python.org/packages/source/s/setuptools
PYTHON_D2TO1_DEPENDENCIES = python

define HOST_PYTHON_D2TO1_BUILD_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py build)
endef

define PYTHON_D2TO1_BUILD_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py build)
endef

define HOST_PYTHON_D2TO1_INSTALL_CMDS
	(cd $(@D); PYTHONPATH="$(HOST_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages"\
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(HOST_DIR)/usr)
endef

define PYTHON_D2TO1_INSTALL_TARGET_CMDS
	(cd $(@D); PYTHONPATH="$(TARGET_DIR)/usr/local/lib/python$(PYTHON_VERSION_MAJOR)/site-packages"\
	$(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr/local)
endef

$(eval $(call GENTARGETS))

$(eval $(call GENTARGETS,host))

