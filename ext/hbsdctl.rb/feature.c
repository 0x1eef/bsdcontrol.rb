#include <libhbsdcontrol.h>
#include <unistd.h>
#include "include/feature.h"
static VALUE get_rb_eError(void);

/**
 * BSD::Control::Feature#set!
 **/
VALUE
feature_set(VALUE self, VALUE path, VALUE state)
{
  int r;
  char *cpath;
  VALUE name;

  if (getuid() != 0) {
    rb_raise(get_rb_eError(), "This operation requires root privileges.");
  }
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
    return (Qtrue);
  } else {
    rb_raise(get_rb_eError(), "hbsdcontrol_set_feature_state failed");
  }
}


static VALUE
get_rb_eError(void)
{
  VALUE rb_mBSD = rb_const_get(rb_cObject, rb_intern("BSD")),
    rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
    rb_eError = rb_const_get(rb_mControl, rb_intern("Error"));
  return (rb_eError);
}
