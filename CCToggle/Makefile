ARCHS = arm64 arm64e
TARGET := iphone:clang:14.5:13.7
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCToggle
CCToggle_BUNDLE_EXTENSION = bundle
CCToggle_FILES = $(shell find Sources/CCToggle -name '*.swift') $(shell find Sources/CCToggleC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
CCToggle_CFLAGS = -fobjc-arc
CCToggle_SWIFTFLAGS = -ISources/CCToggleC/include
CCToggle_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCToggle_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
