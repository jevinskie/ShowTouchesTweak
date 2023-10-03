TARGET := iphone:clang:14.5:14.0


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ShowTouches

MODULESFLAGS += -fno-cxx-modules

ShowTouches_FILES = ShowTouches.xm
ShowTouches_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += showtouchespreferencebundle
include $(THEOS_MAKE_PATH)/aggregate.mk
