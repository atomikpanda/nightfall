include theos/makefiles/common.mk

TWEAK_NAME = Nightfall
Nightfall_FILES = nightfall.mm NightFall.xmi
Nightfall_FRAMEWORKS = UIKit CoreGraphics
Nightfall_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS Telegram Instagram"
SUBPROJECTS += nightfallprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
