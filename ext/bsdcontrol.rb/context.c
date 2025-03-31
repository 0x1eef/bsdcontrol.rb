#include <ruby.h>
#include <libhbsdcontrol.h>
#include <sys/extattr.h>
#include <libutil.h>
#include "context.h"
#include "bsdcontrol.h"

static int FLAGS             = HBSDCTRL_FEATURE_STATE_FLAG_NONE;
static const char *NAMESPACE = LIBHBSDCONTROL_DEFAULT_NAMESPACE;
static void bsdcontrol_context_free(hbsdctrl_ctx_t *);

VALUE
bsdcontrol_context_alloc(VALUE klass)
{
    hbsdctrl_ctx_t *ctx;
    ctx = hbsdctrl_ctx_new(FLAGS, NAMESPACE);
    if (ctx == NULL)
    {
        rb_raise(rb_eSystemCallError, "hbsdctrl_ctx_new");
    }
    return Data_Wrap_Struct(klass, NULL, bsdcontrol_context_free, ctx);
}

static void
bsdcontrol_context_free(hbsdctrl_ctx_t *ctx)
{
    hbsdctrl_ctx_free(&ctx);
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
    ctx  = bsdcontrol_context_unwrap(self);
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
    ctx = bsdcontrol_context_unwrap(self);
    return ULONG2NUM(ctx->hc_version);
}

/*
 * BSD::Control::Context#set_namespace
 * BSD::Control.set_namespace
 */
VALUE
bsdcontrol_context_set_namespace(VALUE self, VALUE namespace)
{
    Check_Type(namespace, T_STRING);
    hbsdctrl_ctx_t *ctx;
    char *ns;
    ns = RSTRING_PTR(namespace);
    if (strcmp(ns, "system") == 0 || strcmp(ns, "user") == 0)
    {
        ctx = bsdcontrol_context_unwrap(self);
        extattr_string_to_namespace(ns, &(ctx->hc_namespace));
        return Qtrue;
    }
    else
    {
        rb_raise(rb_eArgError, "namespace must be 'system' or 'user'");
    }
}

hbsdctrl_ctx_t *
bsdcontrol_context_unwrap(VALUE rbcontext)
{
    hbsdctrl_ctx_t *ctx;
    Data_Get_Struct(rbcontext, hbsdctrl_ctx_t, ctx);
    return ctx;
}
