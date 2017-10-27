extern crate libc;
extern crate emacs;

use std::os::raw::{c_int, c_void, c_char};
use std::ptr::null_mut;

use std::ffi::{CString, CStr};
use emacs::{get_environment, provide,
            bind_function, make_function, find_function};
use emacs::emacs_module::{emacs_env, emacs_value, intmax_t, ptrdiff_t,
                          Struct_emacs_runtime};

unsafe extern fn f_blub(env: *mut emacs_env,
                        _: ptrdiff_t,
                        args: *mut emacs_value,
                        _: *mut c_void)
                        -> emacs_value {
    (*env).make_integer.unwrap()(env, 10001)
}

#[no_mangle]
pub extern fn plugin_is_GPL_compatible() -> libc::c_int { 1 }

#[no_mangle]
pub extern fn emacs_module_init(ert: *mut Struct_emacs_runtime) -> c_int {
    let env = get_environment(ert);
    let defun_blub = make_function(env, 1, 1, Some(f_blub), "blub".to_string(),
                                   null_mut());
    bind_function(env, "blub".to_string(), defun_blub);

    provide(env, "nova".to_string());

    0
}
