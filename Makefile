DEBUG = 0
GO_EASY_ON_ME := 1

ARCHS = arm64
TARGET = iphone:14.5:13.7
THEOS_DEVICE_IP = 192.168.0.17 -p 22

INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ShowTouch

$(TWEAK_NAME)_FILES = $(shell find Sources/ShowTouch -name '*.swift') $(shell find Sources/ShowTouchC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp') $(shell find TouchTracker/Sources/TouchTracker -name '*.swift')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/ShowTouchC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/ShowTouchC/include

include $(THEOS_MAKE_PATH)/tweak.mk
