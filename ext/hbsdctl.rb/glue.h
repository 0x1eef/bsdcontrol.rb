#pragma once
#include <ruby.h>
#include <libhbsdcontrol.h>

int bsdcontrol_open(VALUE);
hbsdctrl_ctx_t* bsdcontrol_unwrap(VALUE);
hbsdctrl_feature_t* bsdcontrol_find_feature(hbsdctrl_ctx_t*, VALUE);
