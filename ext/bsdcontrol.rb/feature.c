#include <ruby.h>
#include <libhbsdcontrol.h>
#include <fcntl.h>
#include <errno.h>
#include "feature.h"
#include "context.h"
#include "bsdcontrol.h"

static int get_feature_state(hbsdctrl_ctx_t *, int, hbsdctrl_feature_t *,
                             hbsdctrl_feature_state_t *);

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
    ctx       = bsdcontrol_context_unwrap(rbcontext);
    feature   = bsdcontrol_feature_find_by_name(ctx, self);
    errno     = 0;
    if (get_feature_state(ctx, fd, feature, &state) == RES_FAIL)
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
    ctx       = bsdcontrol_context_unwrap(rbcontext);
    feature   = bsdcontrol_feature_find_by_name(ctx, self);
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
    ctx       = bsdcontrol_context_unwrap(rbcontext);
    feature   = bsdcontrol_feature_find_by_name(ctx, self);
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

hbsdctrl_feature_t *
bsdcontrol_feature_find_by_name(hbsdctrl_ctx_t *ctx, VALUE rbfeature)
{
    VALUE name;
    name = rb_funcall(rbfeature, rb_intern("name"), 0);
    Check_Type(name, T_STRING);
    return hbsdctrl_ctx_find_feature_by_name(ctx, RSTRING_PTR(name));
}

static int
get_feature_state(hbsdctrl_ctx_t *ctx, int fd, hbsdctrl_feature_t *feature,
                  hbsdctrl_feature_state_t *state)
{
    hbsdctrl_file_states_t *fstate, *tfstate;
    hbsdctrl_file_states_head_t *fstates;
    hbsdctrl_feature_t *f;
    hbsdctrl_feature_state_t *s;
    int res = RES_FAIL;
    fstates = hbsdctrl_get_file_states(ctx, fd);
    LIST_FOREACH_SAFE(fstate, &(fstates->hfsh_states), hfs_entry, tfstate)
    {
        f = hbsdctrl_file_states_get_feature(fstate);
        if (f == NULL)
        {
            break;
        }
        if (strcmp(f->hf_name, feature->hf_name) == 0)
        {
            s = hbsdctrl_file_states_get_feature_state(fstate);
            if (s != NULL)
            {
                *state = *s;
                res    = RES_SUCCESS;
            }
            break;
        }
    }
    hbsdctrl_free_file_states(&fstates);
    return res;
}
