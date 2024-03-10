#include <libhbsdcontrol.h>
#include <errno.h>
#include "include/feature.h"
static VALUE __set(VALUE, VALUE, VALUE);

/**
 * BSD::Control::Feature#set!
 **/
VALUE
feature_set(VALUE self, VALUE rb_path, VALUE rb_state)
{
  Check_Type(rb_path, T_STRING);
  Check_Type(rb_state, T_FIXNUM);
  VALUE rb_feature = rb_funcall(self, rb_intern("name"), 0);
  Check_Type(rb_feature, T_STRING);
  return (__set(rb_path, rb_feature, rb_state));
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
    rb_syserr_fail(errno, "hbsdcontrol_set_feature_state");
  }
}
