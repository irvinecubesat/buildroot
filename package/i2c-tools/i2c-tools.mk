#############################################################
#
# i2c-tools
#
#############################################################

I2C_TOOLS_VERSION = 3.1.2
#I2C_TOOLS_SOURCE = i2c-tools-$(I2C_TOOLS_VERSION).tar.bz2
#I2C_TOOLS_SOURCE = V3-1-0.tar.gz
I2C_TOOLS_SOURCE = i2c-tools-$(I2C_TOOLS_VERSION).tar.gz
#I2C_TOOLS_SITE = http://dl.lm-sensors.org/i2c-tools/releases
#I2C_TOOLS_SITE = https://github.com/groeck/i2c-tools/archive/
I2C_TOOLS_SITE = https://fossies.org/linux/misc/
I2C_TOOLS_INSTALL_STAGING=yes
define I2C_TOOLS_BUILD_CMDS
 $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define I2C_TOOLS_INSTALL_STAGING_CMDS
    $(INSTALL) -m444 -D $(@D)/include/linux/i2c-dev.h $(STAGING_DIR)/usr/include/i2c-tools/linux/i2c-dev.h
endef

define I2C_TOOLS_INSTALL_TARGET_CMDS
	for i in i2cdump i2cget i2cset i2cdetect; \
	do \
		$(INSTALL) -m 755 -D $(@D)/tools/$$i $(TARGET_DIR)/usr/bin/$$i; \
	done
    $(INSTALL) -m444 -D $(@D)/include/linux/i2c-dev.h $(STAGING_DIR)/usr/include/i2c-tools/linux/i2c-dev.h
endef

$(eval $(call GENTARGETS))
