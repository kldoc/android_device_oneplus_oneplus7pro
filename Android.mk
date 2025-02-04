#
# Copyright (C) 2016 The CyanogenMod Project
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
#

#
# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),$(filter $(TARGET_DEVICE),oneplus7 oneplus7pro))

subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
$(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))


include $(CLEAR_VARS)

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

NXP_LIB := libnxpnfc_nci_jni.so
NXP_SYMLINKS := $(addprefix $(TARGET_OUT_APPS)/NxpNfcNci/lib/arm64/,$(notdir $(NXP_LIB)))
$(NXP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "NXP lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(NXP_SYMLINKS)

#
#WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini
#$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
#	@echo "WCNSS config ini link: $@"
#	@mkdir -p $(dir $@)
#	@rm -rf $@
#	$(hide) ln -sf /system/vendor/etc/wifi/$(notdir $@) $@
#
#WCNSS_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/wlan_mac.bin
#$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
#	@echo "WCNSS MAC bin link: $@"
#	@mkdir -p $(dir $@)
#	@rm -rf $@
#	$(hide) ln -sf /persist/$(notdir $@) $@
#
#ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_MAC_SYMLINK) $(WCNSS_INI_PERSIST_SYMLINK)
#
#$(shell ln -sf /persist/WCNSS_qcom_cfg.ini $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/WCNSS_qcom_cfg_persist.ini)
#
#BT_FIRMWARE := apbtfw10.tlv apnv10.bin crbtfw11.tlv crbtfw20.tlv crbtfw21.tlv crnv11.bin crnv20.bin crnv21.bin
#BT_FIRMWARE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(BT_FIRMWARE)))
#$(BT_FIRMWARE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
#	@echo "Creating BT firmware symlink: $@"
#	@mkdir -p $(dir $@)
#	@rm -rf $@
#	$(hide) ln -sf /bt_firmware/image/$(notdir $@) $@
#
#ALL_DEFAULT_INSTALLED_MODULES += $(BT_FIRMWARE_SYMLINKS)
#
#$(shell mkdir -p $(TARGET_OUT_VENDOR)/etc/firmware/wcd9320; \
#        ln -sf /data/vendor/misc/audio/wcd9320_anc.bin \
#                $(TARGET_OUT_VENDOR)/etc/firmware/wcd9320/wcd9320_anc.bin;\
#        ln -s /data/vendor/misc/audio/mbhc.bin \
#                $(TARGET_OUT_VENDOR)/etc/firmware/wcd9320/wcd9320_mbhc.bin; \
#        ln -s /data/vendor/misc/audio/wcd9320_mad_audio.bin \
#                $(TARGET_OUT_VENDOR)/etc/firmware/wcd9320/wcd9320_mad_audio.bin)
#
## Create symbolic links for msadp
#$(shell  mkdir -p $(TARGET_OUT_VENDOR)/firmware; \
#	ln -sf /dev/block/bootdevice/by-name/msadp \
#	$(TARGET_OUT_VENDOR)/firmware/msadp)
#
#-include device/oneplus/oneplus6/tftp.mk

endif
