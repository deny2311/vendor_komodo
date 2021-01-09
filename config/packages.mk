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

# Extra tools
PRODUCT_PACKAGES += \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    libsepol \
    nano \
    wget \
    xz \
    zip
