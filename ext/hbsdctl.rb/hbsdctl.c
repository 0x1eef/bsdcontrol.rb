#include <ruby.h>
#include "include/ffi.h"
#include "include/feature.h"

void
Init_hbsdctl(void)
{
  VALUE rb_mBSD = rb_const_get(rb_cObject, rb_intern("BSD")),
    rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
    rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
    rb_mFFI = rb_const_get(rb_mControl, rb_intern("FFI"));

  rb_define_const(rb_mControl, "Disable", INT2NUM(0));
  rb_define_const(rb_mControl, "Enable", INT2NUM(1));
  rb_define_singleton_method(rb_mFFI, "available_features", ffi_available_features, 0);
  rb_define_singleton_method(rb_mFFI, "library_version", ffi_library_version, 0);
  rb_define_singleton_method(rb_mFFI, "reset!", ffi_reset, 2);
  rb_define_singleton_method(rb_mFFI, "status", ffi_status, 2);
  rb_define_private_method(rb_cFeature, "set!", feature_set, 2);
}
