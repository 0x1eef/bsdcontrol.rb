#include <ruby.h>
#include <libhbsdcontrol.h>

struct bsdcontrol_ctx_t {
  hbsdctrl_ctx_t *ctx;
};

VALUE bsdcontrol_context_alloc(VALUE);
VALUE bsdcontrol_context_library_version(VALUE);
VALUE bsdcontrol_context_available_features(VALUE);
