CMAKE_VERSION = 3.5.2
CMAKE_SITE = http://www.cmake.org/files/v3.5/

define HOST_CMAKE_CONFIGURE_CMDS
 (cd $(@D); \
	LDFLAGS="$(HOST_LDFLAGS)" \
	CFLAGS="$(HOST_CFLAGS)" \
	./bootstrap --prefix=$(HOST_DIR)/usr --parallel=$(BR2_JLEVEL) \
 )
endef

define HOST_CMAKE_BUILD_CMDS
 $(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_CMAKE_INSTALL_CMDS
 $(HOST_MAKE_ENV) $(MAKE) -C $(@D) install
endef

$(eval $(call GENTARGETS))
$(eval $(call GENTARGETS,host))
