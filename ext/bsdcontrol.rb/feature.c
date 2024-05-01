#include <ruby.h>
#include <libhbsdcontrol.h>
#include <fcntl.h>
#include <errno.h>
#include "feature.h"
#include "context.h"
#include "glue.h"

/*
 * BSD::Control::Feature#status
 */
VALUE
bsdcontrol_feature_status(VALUE self, VALUE path)
{
  int fd;
  VALUE rbcontext;
  hbsdctrl_feature_t *feature;
  hbsdctrl_feature_state_t state;
  hbsdctrl_ctx_t *ctx;
  rbcontext = rb_funcall(self, rb_intern("context"), 0);
  fd        = bsdcontrol_open(path);
  ctx       = bsdcontrol_unwrap(rbcontext);
  feature   = bsdcontrol_find_feature(ctx, self);
  errno     = 0;
  if (feature->hf_get(ctx, feature, &fd, &state) == RES_FAIL)
  {
    close(fd);
    errno == 0 ? rb_raise(rb_eSystemCallError, "hf_get")
               : rb_syserr_fail(errno, "hf_get");
  }
  else
  {
    const char *str;
    close(fd);
    str = hbsdctrl_feature_state_to_string(&state);
    return ID2SYM(rb_intern(str));
  }
}

/*
 * BSD::Control::Feature#set!
 */
VALUE
bsdcontrol_feature_set(VALUE self, VALUE path, VALUE rbstate)
{
  int fd;
  VALUE rbcontext;
  hbsdctrl_feature_t *feature;
  hbsdctrl_ctx_t *ctx;
  int state;
  rbcontext = rb_funcall(self, rb_intern("context"), 0);
  fd        = bsdcontrol_open(path);
  ctx       = bsdcontrol_unwrap(rbcontext);
  feature   = bsdcontrol_find_feature(ctx, self);
  state     = NUM2INT(rbstate);
  errno     = 0;
  if (feature->hf_apply(ctx, feature, &fd, &state) == RES_FAIL)
  {
    close(fd);
    errno == 0 ? rb_raise(rb_eSystemCallError, "hf_apply")
               : rb_syserr_fail(errno, "hf_apply");
  }
  else
  {
    close(fd);
    return Qtrue;
  }
}

/*
 * BSD::Control::Feature#sysdef!
 */
VALUE
bsdcontrol_feature_sysdef(VALUE self, VALUE path)
{
  int fd;
  VALUE rbcontext;
  hbsdctrl_feature_t *feature;
  hbsdctrl_ctx_t *ctx;
  rbcontext = rb_funcall(self, rb_intern("context"), 0);
  fd        = bsdcontrol_open(path);
  ctx       = bsdcontrol_unwrap(rbcontext);
  feature   = bsdcontrol_find_feature(ctx, self);
  errno     = 0;
  if (feature->hf_unapply(ctx, feature, &fd, NULL) == RES_FAIL)
  {
    close(fd);
    errno == 0 ? rb_raise(rb_eSystemCallError, "hf_unapply")
               : rb_syserr_fail(errno, "hf_unapply");
  }
  else
  {
    close(fd);
    return Qtrue;
  }
}
