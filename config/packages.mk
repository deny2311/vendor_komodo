# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Required
PRODUCT_PACKAGES += \
    ThemePicker \
    komodoOverlayStub \
    OmniStyle \
    Longshot \
    NoCutoutOverlay \
    Recorder \
    RetroMusicPlayer \
    QuickAccessWallet

# Google Camera Go
TARGET_USES_GCAMGO ?= true
ifeq ($(TARGET_USES_GCAMGO),true)
PRODUCT_PACKAGES += \
    GoogleCameraGo
endif

# Extra apps
ifeq ($(KOMODO_GAPPS_TYPE), nogapps)
PRODUCT_PACKAGES += \
    messaging \
    Gallery2 \
    Dialer \
    FirefoxLite \
    GboardGoPreb \
    ExactCalculator
endif
