#include <libhbsdcontrol.h>
#include <unistd.h>
#include "include/feature.h"
static VALUE __rb_eError(void);
static VALUE __set(VALUE, VALUE, VALUE);

/**
 * BSD::Control::Feature#set!
 **/
VALUE
feature_set(VALUE self, VALUE rb_path, VALUE rb_state)
{
  Check_Type(rb_path, T_STRING);
  Check_Type(rb_state, T_FIXNUM);
  if (getuid() != 0) {
    rb_raise(__rb_eError(), "This operation requires root privileges.");
  } else if (rb_funcall(rb_cFile, rb_intern("exist?"), 1, rb_path) == Qfalse) {
    rb_raise(__rb_eError(), "The given path does not exist.");
  } else {
    VALUE rb_feature = rb_funcall(self, rb_intern("name"), 0);
    Check_Type(rb_feature, T_STRING);
    return (__set(rb_path, rb_feature, rb_state));
  }
}


static VALUE
__set(VALUE rb_path, VALUE rb_feature, VALUE rb_state)
{
  int result = hbsdcontrol_set_feature_state(
    RSTRING_PTR(rb_path),
    RSTRING_PTR(rb_feature),
    NUM2INT(rb_state)
    );
  if (result == 0) {
    return (Qtrue);
  } else {
    rb_raise(__rb_eError(), "hbsdcontrol_set_feature_state failed");
  }
}


static VALUE
__rb_eError(void)
{
  VALUE rb_mBSD = rb_const_get(rb_cObject, rb_intern("BSD")),
    rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
    rb_eError = rb_const_get(rb_mControl, rb_intern("Error"));
  return (rb_eError);
}
