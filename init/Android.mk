LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := \
    system/core/base/include \
    system/core/init \
    external/selinux/libselinux/include

LOCAL_STATIC_LIBRARIES := libbase

LOCAL_CPP_FLAGS := -Wall -Werror
LOCAL_SRC_FILES := init_yoshino.cpp ta.cpp
ifneq ($(TARGET_LIBINIT_YOSHINO_DEFINES_FILE),)
  LOCAL_SRC_FILES += ../../../../$(TARGET_LIBINIT_YOSHINO_DEFINES_FILE)
endif

LOCAL_MODULE := libinit_yoshino
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)
