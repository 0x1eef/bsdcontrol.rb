#include <ruby.h>
#include <libhbsdcontrol.h>

static VALUE
ffi_library_version(VALUE self)
{
  const char *ver;
  ver = hbsdcontrol_get_version();
  return rb_str_new2(ver);
}

static VALUE
ffi_available_features(VALUE self)
{
  const struct pax_feature_entry *entry = &pax_features[0];
  VALUE rb_mBSD     = rb_const_get(rb_cObject, rb_intern("BSD")),
        rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
        rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
        features = rb_ary_new(),
        feature = 0;

  while (entry->feature != NULL) {
    feature = rb_funcall(
      rb_cFeature,
      rb_intern("new"),
      3,
      rb_str_new2(entry->feature),
      rb_str_new2(entry->extattr[1]),
      rb_str_new2(entry->extattr[0])
    );
    rb_ary_push(features, feature);
    entry++;
  }
  return features;
}

static VALUE
feature_set(VALUE self, VALUE path, VALUE state)
{
  int r;
  char *cpath;
  VALUE name;

  Check_Type(path, T_STRING);
  Check_Type(state, T_FIXNUM);
  cpath = RSTRING_PTR(path);
  name = rb_funcall(self, rb_intern("name"), 0);
  Check_Type(name, T_STRING);
  r = hbsdcontrol_set_feature_state(
    cpath,
    RSTRING_PTR(name),
    NUM2INT(state)
  );
  if (r == 0) {
    return Qtrue;
  } else {
    VALUE rb_mBSD = rb_const_get(rb_cObject, rb_intern("BSD")),
          rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
          rb_eError = rb_const_get(rb_mControl, rb_intern("Error"));
    rb_raise(rb_eError, "hbsdcontrol_set_feature_state failed");
  }
}

void
Init_hbsdctl(void)
{
  VALUE rb_mBSD     = rb_const_get(rb_cObject, rb_intern("BSD")),
        rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
        rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
        rb_mFFI     = rb_const_get(rb_mControl, rb_intern("FFI"));

  rb_define_const(rb_mControl, "SysDef", -1);
  rb_define_const(rb_mControl, "Disable", 0);
  rb_define_const(rb_mControl, "Enable", 1);
  rb_define_singleton_method(rb_mFFI, "available_features", ffi_available_features, 0);
  rb_define_singleton_method(rb_mFFI, "library_version", ffi_library_version, 0);
  rb_define_method(rb_cFeature, "set!", feature_set, 2);
}
