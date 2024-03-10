#include <libhbsdcontrol.h>
#include <ruby.h>
#include <sys/extattr.h>
#include <libutil.h>
#include <errno.h>
#include "include/ffi.h"

static struct Options __options_init(VALUE, VALUE);

struct Options {
  char *path;
  char *enable_flag;
  char *disable_flag;
};

/**
 * BSD::Control::FFI.available_features
 **/
VALUE
ffi_available_features(VALUE self)
{
  const struct pax_feature_entry *entry = &pax_features[0];
  VALUE rb_mBSD = rb_const_get(rb_cObject, rb_intern("BSD")),
    rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
    rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
    features = rb_ary_new(),
    feature = 0;

  while (entry->feature != NULL)
  {
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
  return (features);
}


/**
 * BSD::Control::FFI.sysdef!
 **/
VALUE
ffi_sysdef(VALUE self, VALUE rb_feature, VALUE rb_path)
{
  struct Options options;
  int result;
  errno = 0;
  options = __options_init(rb_feature, rb_path);
  result = hbsdcontrol_extattr_rm_attr(options.path, options.disable_flag) == 0 &&
    hbsdcontrol_extattr_rm_attr(options.path, options.enable_flag) == 0;
  if (result) {
    return (Qtrue);
  } else {
    rb_syserr_fail(errno, "hbsdcontrol_extattr_rm_attr");
  }
}


/**
 * BSD::Control::FFI.status
 **/
VALUE
ffi_status(VALUE self, VALUE rb_feature, VALUE rb_path)
{
  struct Options options;
  char enable_data[2], disable_data[2];
  int ns;

  options = __options_init(rb_feature, rb_path);
  if (extattr_string_to_namespace("system", &ns) == -1) {
    rb_syserr_fail(errno, "extattr_string_to_namespace");
  }
  if (
    extattr_get_file(
      options.path, ns,
      options.enable_flag, &enable_data,
      2) == -1) {
    rb_syserr_fail(errno, "extattr_get_file");
  }
  if (
    extattr_get_file(
      options.path, ns,
      options.disable_flag, &disable_data,
      2) == -1) {
    rb_syserr_fail(errno, "extattr_get_file");
  }
  if (strncmp(enable_data, disable_data, 1) == 0) {
    return (ID2SYM(rb_intern("conflict")));
  } else if (strncmp(enable_data, "1", 1) == 0) {
    return (ID2SYM(rb_intern("enabled")));
  } else {
    return (ID2SYM(rb_intern("disabled")));
  }
}


/**
 * BSD::Control::FFI.library_version
 **/
VALUE
ffi_library_version(VALUE self)
{
  const char *ver;
  ver = hbsdcontrol_get_version();
  return (rb_str_new2(ver));
}


static
struct Options
__options_init(VALUE rb_feature, VALUE rb_path)
{
  VALUE rb_enable_flag, rb_disable_flag;
  struct Options options;

  rb_enable_flag = rb_funcall(rb_feature, rb_intern("enable"), 0);
  rb_disable_flag = rb_funcall(rb_feature, rb_intern("disable"), 0);
  Check_Type(rb_enable_flag, T_STRING);
  Check_Type(rb_disable_flag, T_STRING);
  Check_Type(rb_path, T_STRING);
  options.path = RSTRING_PTR(rb_path);
  options.enable_flag = RSTRING_PTR(rb_enable_flag);
  options.disable_flag = RSTRING_PTR(rb_disable_flag);
  return (options);
}
