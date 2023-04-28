DEBUG = 0
GO_EASY_ON_ME := 1

ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = showtouch

$(BUNDLE_NAME)_FRAMEWORKS = UIKit CoreGraphics SwiftUI
#$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_FILES = $(shell find Sources/showtouch -name '*.swift') $(shell find Sources/showtouchC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(BUNDLE_NAME)_SWIFTFLAGS = -ISources/showtouchC/include
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
