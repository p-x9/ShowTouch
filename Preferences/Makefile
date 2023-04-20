DEBUG = 1
#GO_EASY_ON_ME := 1

ARCHS = arm64
TARGET = iphone:clang:latest:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = showtouch

$(BUNDLE_NAME)_FRAMEWORKS = UIKit CoreGraphics SwiftUI
#$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
showtouch_FILES = $(shell find Sources/showtouch -name '*.swift') $(shell find Sources/showtouchC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
showtouch_SWIFTFLAGS = -ISources/showtouchC/include
showtouch_INSTALL_PATH = /Library/PreferenceBundles
showtouch_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
