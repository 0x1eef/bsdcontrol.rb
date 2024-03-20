#include <ruby.h>
#include <libhbsdcontrol.h>
#include "context.h"
#include "glue.h"

static int FLAGS             = HBSDCTRL_FEATURE_STATE_FLAG_NONE;
static const char *NAMESPACE = LIBHBSDCONTROL_DEFAULT_NAMESPACE;
static void bsdcontrol_context_free(struct bsdcontrol_ctx_t *);

VALUE
bsdcontrol_context_alloc(VALUE klass)
{
  hbsdctrl_ctx_t *ctx;
  struct bsdcontrol_ctx_t *rbctx;
  ctx   = hbsdctrl_ctx_new(FLAGS, NAMESPACE);
  rbctx = calloc(1, sizeof(struct bsdcontrol_ctx_t));
  if (ctx == NULL || rbctx == NULL)
  {
    rb_raise(rb_eRuntimeError, "...");
  }
  rbctx->ctx = ctx;
  return Data_Wrap_Struct(klass, NULL, bsdcontrol_context_free, rbctx);
}

static void
bsdcontrol_context_free(struct bsdcontrol_ctx_t *rbctx)
{
  hbsdctrl_ctx_free(&rbctx->ctx);
  free(rbctx);
}

/*
 * BSD::Control::Context#available_features
 * BSD::Control.available_features
 * BSD::Control::Feature.available
 */
VALUE
bsdcontrol_context_available_features(VALUE self)
{
  VALUE rb_mBSD     = rb_const_get(rb_cObject, rb_intern("BSD")),
        rb_mControl = rb_const_get(rb_mBSD, rb_intern("Control")),
        rb_cFeature = rb_const_get(rb_mControl, rb_intern("Feature")),
        feature = 0, features = rb_ary_new();
  hbsdctrl_ctx_t *ctx;
  char **name;
  ctx  = bsdcontrol_unwrap(self);
  name = hbsdctrl_ctx_all_feature_names(ctx);
  while (*name != NULL)
  {
    feature = rb_funcall(
        rb_cFeature, rb_intern("new"), 2, rb_str_new2(*name), self);
    rb_ary_push(features, feature);
    name++;
  }
  return features;
}

/*
 * BSD::Control::Context#library_version
 * BSD::Control.library_version
 */
VALUE
bsdcontrol_context_library_version(VALUE self)
{
  hbsdctrl_ctx_t *ctx;
  ctx = bsdcontrol_unwrap(self);
  return ULONG2NUM(ctx->hc_version);
}
