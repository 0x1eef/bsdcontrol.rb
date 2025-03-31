#include <ruby.h>
#include <libhbsdcontrol.h>

VALUE bsdcontrol_context_alloc(VALUE);
VALUE bsdcontrol_context_library_version(VALUE);
VALUE bsdcontrol_context_available_features(VALUE);
VALUE bsdcontrol_context_set_namespace(VALUE, VALUE);
VALUE bsdcontrol_context_get_namespace(VALUE);
hbsdctrl_ctx_t* bsdcontrol_context_unwrap(VALUE);
