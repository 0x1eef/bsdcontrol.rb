#include <ruby.h>
#include <libhbsdcontrol.h>
#include <fcntl.h>
#include <errno.h>

#include "context.h"
#include "feature.h"
#include "bsdcontrol.h"

void
Init_bsdcontrol(void)
{
    VALUE rb_mBSD     = rb_const_get(rb_cObject, rb_intern("BSD")),
          rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
          rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
          rb_cContext = rb_const_get(rb_mControl, rb_intern("Context"));
    rb_define_alloc_func(rb_cContext, bsdcontrol_context_alloc);
    rb_define_method(
        rb_cContext, "library_version", bsdcontrol_context_library_version, 0);
    rb_define_method(
        rb_cContext, "set_namespace", bsdcontrol_context_set_namespace, 1);
    rb_define_method(
        rb_cContext, "namespace", bsdcontrol_context_get_namespace, 0);
    rb_define_method(rb_cContext,
                     "available_features",
                     bsdcontrol_context_available_features,
                     0);
    rb_define_method(rb_cFeature, "status", bsdcontrol_feature_status, 1);
    rb_define_method(rb_cFeature, "sysdef!", bsdcontrol_feature_sysdef, 1);
    rb_define_private_method(rb_cFeature, "set!", bsdcontrol_feature_set, 2);
    rb_define_const(rb_cFeature, "ENABLED", INT2NUM(HBSDCTRL_STATE_ENABLED));
    rb_define_const(rb_cFeature, "DISABLED", INT2NUM(HBSDCTRL_STATE_DISABLED));
}

int
bsdcontrol_open(VALUE path)
{
    int fd;
    Check_Type(path, T_STRING);
    fd = open(RSTRING_PTR(path), O_PATH);
    if (fd == -1)
    {
        rb_syserr_fail(errno, "open");
    }
    return fd;
}
