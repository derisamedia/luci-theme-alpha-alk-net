# LuCI AlphaProto Theme
# Copyright 2024 derisamedia <yuimizuno86@gmail.com>
#
# Licensed under the Apache License v2.0
# http://www.apache.org/licenses/LICENSE-2.0

include $(TOPDIR)/rules.mk

THEME_NAME:=alphaproto
THEME_TITLE:=AlphaProto

PKG_NAME:=luci-theme-$(THEME_NAME)
PKG_VERSION:=0.0.2-beta
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-theme-$(THEME_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=9. Themes
  DEPENDS:=+libc
  TITLE:=Prototype Test
  URL:=http://github.derisamedia/
  PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-theme-$(THEME_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	echo "uci set luci.themes.$(THEME_TITLE)=/luci-static/$(THEME_NAME); uci commit luci" > $(1)/etc/uci-defaults/30-luci-theme-$(THEME_NAME)
	$(INSTALL_DIR) $(1)/www/luci-static/$(THEME_NAME)
	$(CP) -a ./luasrc/* $(1)/www/luci-static/$(THEME_NAME)/ 2>/dev/null || true
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)
	$(CP) -a ./template/* $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)/ 2>/dev/null || true
	$(INSTALL_DIR) $(1)/www/luci-static/resources
	$(CP) -a ./javascript/* $(1)/www/luci-static/resources/ 2>/dev/null || true
endef

define Package/luci-theme-$(THEME_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/30-luci-theme-$(THEME_NAME) ) && rm -f /etc/uci-defaults/30-luci-theme-$(THEME_NAME)
}
endef

$(eval $(call BuildPackage,luci-theme-$(THEME_NAME)))
