include theos/makefiles/common.mk

TWEAK_NAME = Nightfall
Nightfall_FILES = nightfall.mm NightFall.xmi
Nightfall_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
SUBPROJECTS += nightfallprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
