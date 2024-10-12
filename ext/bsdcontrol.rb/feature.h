#pragma once

#include <ruby.h>
#include <libhbsdcontrol.h>

VALUE bsdcontrol_feature_status(VALUE, VALUE);
VALUE bsdcontrol_feature_set(VALUE,VALUE,VALUE);
VALUE bsdcontrol_feature_sysdef(VALUE, VALUE);
hbsdctrl_feature_t* bsdcontrol_feature_find_by_name(hbsdctrl_ctx_t*, VALUE);
