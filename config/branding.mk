# Define Var
CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

# Komodo Version
KOMODO_PLATFORM_VERSION := 3.0
KOMODO_VERSION_NAME := Reptile

# Set all versions
KOMODO_DATE_YEAR := $(shell date -u +%Y)
KOMODO_DATE_MONTH := $(shell date -u +%m)
KOMODO_DATE_DAY := $(shell date -u +%d)
KOMODO_DATE_HOUR := $(shell date -u +%H)
KOMODO_DATE_MINUTE := $(shell date -u +%M)
KOMODO_BUILD_DATE := $(KOMODO_DATE_YEAR)$(KOMODO_DATE_MONTH)$(KOMODO_DATE_DAY)-$(KOMODO_DATE_HOUR)$(KOMODO_DATE_MINUTE)

# Default, it can be overriden.
KOMODO_BUILD_TYPE ?= DEV

# Komodo Official Release
LIST = $(shell cat vendor/komodo/komodo.devices | awk '{ print $$1 }')

ifeq ($(KOMODO_VARIANT), RELEASE)
   ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      KOMODO_BUILD_TYPE := RELEASE
      IS_RELEASE := true

      # OTA
      KOMODO_OTA_VERSION_CODE := 11

      KOMODO_PROPERTIES += \
         org.komodo.ota.version_code=$(KOMODO_OTA_VERSION_CODE) \
         sys.ota.disable_uncrypt=1

      PRODUCT_PACKAGES += \
          Updates

  endif
  ifneq ($(IS_RELEASE), true)
      KOMODO_BUILD_TYPE := DEV
  endif
endif

ifeq ($(KOMODO_VARIANT), BETA)
   ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      KOMODO_BUILD_TYPE := BETA
      IS_TEST := true
   endif
   ifneq ($(IS_TEST), true)
     KOMODO_BUILD_TYPE := DEV
   endif
endif

# Type of GAPPS
ifeq ($(KOMODO_GAPPS_TYPE), nogapps)
     KOMODO_BUILD_GAPPS_TYPE := TOXICOFERA
else ifeq ($(KOMODO_GAPPS_TYPE), microg)
     KOMODO_BUILD_GAPPS_TYPE := MICROG
else ifeq ($(KOMODO_GAPPS_TYPE), gapps)
     KOMODO_BUILD_GAPPS_TYPE := GAPPS
else
    ifeq ($(KOMODO_GAPPS_TYPE),)
        $(warning "Komodo vendor: KOMODO_GAPPS_TYPE is undefined, assuming nogapps")
    else
        $(warning "Komodo vendor: Incorrect value for KOMODO_GAPPS_TYPE, forcing nogapps")
    endif
    KOMODO_BUILD_GAPPS_TYPE := TOXICOFERA
    KOMODO_GAPPS_TYPE := nogapps
endif

KOMODO_VERSION := KomodoOS-$(KOMODO_BUILD)-$(KOMODO_PLATFORM_VERSION)-$(KOMODO_BUILD_DATE)-$(KOMODO_BUILD_TYPE)-$(KOMODO_BUILD_GAPPS_TYPE)

TARGET_PRODUCT_SHORT := $(subst komodo_,,$(KOMODO_BUILD))

ROM_FINGERPRINT := KomodoOS/$(KOMODO_PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(KOMODO_BUILD_DATE)

KOMODO_PROPERTIES := \
    org.komodo.version=$(KOMODO_PLATFORM_VERSION) \
    org.komodo.version.display=$(KOMODO_VERSION) \
    org.komodo.build_type=$(KOMODO_BUILD_TYPE) \
    org.komodo.gapps_type=$(KOMODO_BUILD_GAPPS_TYPE) \
    org.komodo.fingerprint=$(ROM_FINGERPRINT) \
    org.komodo.version.name=$(KOMODO_VERSION_NAME)

# Variable file name for jenkins
$(info) $(shell echo $(KOMODO_VERSION) > $(OUT_DIR)/var-file_name)
