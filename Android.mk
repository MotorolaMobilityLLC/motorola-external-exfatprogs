#
# Free exFAT implementation.
# Copyright (C) 2017  liminghao
# Copyright (C) 2017  Motorola Mobility LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
ifeq ($(TARGET_USE_EXFATPROGS),true)
LOCAL_PATH:= $(call my-dir)

exfatprogs_common_cflags :=

########################################
# static library: libexfatprogs.a

libexfatprogs_src_files := \
    lib/libexfat.c

libexfatprogs_headers := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/lib

libexfatprogs_shared_libraries :=

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := libexfatprogs
LOCAL_MODULE_TAGS := optional
ifeq (true,$(call math_gt_or_eq,$(PRODUCT_SHIPPING_API_LEVEL),30))
LOCAL_PRODUCT_MODULE := true
endif
LOCAL_SRC_FILES := $(libexfatprogs_src_files)
LOCAL_CFLAGS := $(exfatprogs_common_cflags)
LOCAL_C_INCLUDES := $(libexfatprogs_headers)
LOCAL_SHARED_LIBRARIES := $(libexfatprogs_shared_libraries)

include $(BUILD_STATIC_LIBRARY)

########################################
# executable: mkfs.exfat

mkexfatprogsfs_src_files := \
    mkfs/mkfs.c \
    mkfs/upcase.c
    
mkexfatprogsfs_headers := \
    $(libexfatprogs_headers) \
    $(LOCAL_PATH)/mkfs

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := mkfs.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_PRODUCT_MODULE := true
LOCAL_SRC_FILES := $(mkexfatprogsfs_src_files)
LOCAL_CFLAGS := $(exfatprogs_common_cflags)
LOCAL_C_INCLUDES := $(mkexfatprogsfs_headers)
LOCAL_STATIC_LIBRARIES := libexfatprogs
LOCAL_SHARED_LIBRARIES := $(libexfatprogs_shared_libraries)

include $(BUILD_EXECUTABLE)

########################################
# executable: fsck.exfat

exfatprogsfsckp_src_files := fsck/fsck.c \
                       fsck/de_iter.c \
                       fsck/repair.c
exfatprogsfsck_headers := \
    $(libexfatprogs_headers) \
    $(LOCAL_PATH)/fsck

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := fsck.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_PRODUCT_MODULE := true
LOCAL_SRC_FILES := $(exfatprogsfsckp_src_files)
LOCAL_CFLAGS := $(exfatprogs_common_cflags)
LOCAL_C_INCLUDES := $(exfatprogsfsck_headers)
LOCAL_STATIC_LIBRARIES := libexfatprogs
LOCAL_SHARED_LIBRARIES := $(libexfatprogs_shared_libraries)

include $(BUILD_EXECUTABLE)

########################################
# executable: tune.exfat

tuneexfat_src_files := tune/tune.c

tuneexfat_headers := \
    $(libexfatprogs_headers) \
    $(LOCAL_PATH)/tune

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := tune.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_PRODUCT_MODULE := true
LOCAL_SRC_FILES := $(tuneexfat_src_files)
LOCAL_CFLAGS := $(exfatprogs_common_cflags)
LOCAL_C_INCLUDES := $(tuneexfat_headers)
LOCAL_STATIC_LIBRARIES := libexfatprogs
LOCAL_SHARED_LIBRARIES := $(libexfatprogs_shared_libraries)

include $(BUILD_EXECUTABLE)
endif
