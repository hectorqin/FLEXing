export ARCHS = arm64 arm64e
export TARGET = iphone:latest:9.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FLEXing
${TWEAK_NAME}_FILES = Tweak.xm SpringBoard.xm
${TWEAK_NAME}_CFLAGS += -fobjc-arc -w
$(TWEAK_NAME)_FRAMEWORKS += UIKit
# $(TWEAK_NAME)_PRIVATE_FRAMEWORKS += Preferences
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"

# For printing variables from the makefile
print-%  : ; @echo $* = $($*)

# The SUBPROJECTS feature bundles both projects into
# one package. We want two separate packages.
#
# SUBPROJECTS += libflex

SUBPROJECTS += Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
