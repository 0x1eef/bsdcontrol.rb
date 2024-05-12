#include <ruby.h>
#include <libhbsdcontrol.h>
#include <fcntl.h>
#include "glue.h"
#include "context.h"

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

hbsdctrl_ctx_t *
bsdcontrol_unwrap(VALUE rbcontext)
{
    hbsdctrl_ctx_t *ctx;
    Data_Get_Struct(rbcontext, hbsdctrl_ctx_t, ctx);
    return ctx;
}

hbsdctrl_feature_t *
bsdcontrol_find_feature(hbsdctrl_ctx_t *ctx, VALUE rbfeature)
{
    VALUE name;
    name = rb_funcall(rbfeature, rb_intern("name"), 0);
    Check_Type(name, T_STRING);
    return hbsdctrl_ctx_find_feature_by_name(ctx, RSTRING_PTR(name));
}
