# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_BRAND := BiancaProject
VERSION := 2.0
OTA_VERSION := 12

# Official tag
ifeq ($(BIANCA_OFFICIAL), true)
    BIANCA_BUILD_TYPE := OFFICIAL
else
    BIANCA_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(WITH_GAPPS), true)
    BIANCA_VERSION := $(PRODUCT_BRAND)-v$(VERSION)-Gapps-$(BIANCA_BUILD_TYPE)-$(BIANCA_BUILD)-$(shell date +%d%m%Y-%H%M)
else
    BIANCA_VERSION := $(PRODUCT_BRAND)-v$(VERSION)-$(BIANCA_BUILD_TYPE)-$(BIANCA_BUILD)-$(shell date +%d%m%Y-%H%M)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.bianca.version=$(BIANCA_VERSION) \
  ro.bianca.releasetype=$(BIANCA_BUILD_TYPE) \
  ro.bianca.ota.version=$(OTA_VERSION) \
  ro.modversion=$(VERSION)

BIANCA_DISPLAY_VERSION := $(PRODUCT_BRAND)-v$(VERSION)-$(BIANCA_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.bianca.display.version=$(BIANCA_DISPLAY_VERSION)

# Gapps
ifeq ($(WITH_GAPPS),true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
endif

