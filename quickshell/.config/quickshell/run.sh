#!/bin/sh
# Launch caelestia-shell from local config instead of nix store
exec env \
  NIXPKGS_QT6_QML_IMPORT_PATH="/nix/store/76xgd5bmfpx6l091disw8sc26fqyz128-quickshell-wrapped-0.3.0/lib/qt-6/qml:/nix/store/3s8kj3r58w90nakdfffp86ma8q3f9fhr-caelestia-qml-plugin/lib/qt-6/qml:/nix/store/siilgabgqywcsixr87hqrn9d1j7y53pa-caelestia-m3shapes/lib/qt-6/qml" \
  QT_PLUGIN_PATH="/nix/store/ip1kxiyrb3zhv27fwlmqbixb9bfkpdx4-qtbase-6.11.0-only-plugins-qml/lib/qt-6/plugins:/nix/store/wzvm2pvf98a71v0scgfhmi01lqcxahfr-qtbase-6.11.0/lib/qt-6/plugins" \
  FONTCONFIG_FILE="/nix/store/7a01y6kz53dmr0hhfswnp7515m6rf9rv-fonts.conf" \
  CAELESTIA_LIB_DIR="/nix/store/gwbmmsri2rxvmpmdgaq1ipymc68qkfk2-caelestia-extras/lib" \
  CAELESTIA_XKB_RULES_PATH="/nix/store/70naj3m24b7ynbzv211q50hlq4cmsv51-xkeyboard-config-2.47/share/xkeyboard-config-2/rules/base.lst" \
  /nix/store/76xgd5bmfpx6l091disw8sc26fqyz128-quickshell-wrapped-0.3.0/bin/qs -p ~/.config/quickshell "$@"
