licenses(['notice'])
package(default_visibility=['//visibility:public'])

load(':absl_build_system.bzl', 'absl_cc_library')

# This BUILD file is modified by concatenating all existing BUILD.bazel files
# together:
#       for f in $(find abseil-cpp/absl -name BUILD.bazel.orig); do echo $f >> BUILD && cat $f >> BUILD; done;

config_setting(
    name = 'llvm_compiler',
    values = {
        #'compiler': 'llvm',
        # TODO (zhongming): I am using --cpu=clang to choose a llvm-clang-5.0.0
        # based toolchain.  Should understand the difference between --compiler
        # and --cpu.
        'cpu': 'clang',
    },
    visibility = [':__pkg__'],
)

# following configs are based on mapping defined in: https://git.io/v5Ijz
config_setting(
    name = 'ios',
    values = {
        'cpu': 'darwin',
    },
    visibility = [':__pkg__'],
)

config_setting(
    name = 'windows',
    values = {
        'cpu': 'x64_windows',
    },
    visibility = [':__pkg__'],
)

config_setting(
    name = 'ppc',
    values = {
        'cpu': 'ppc',
    },
    visibility = [':__pkg__'],
)

GCC_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Wcast-qual',
    '-Wconversion-null',
    '-Wmissing-declarations',
    '-Wno-sign-compare',
    '-Woverlength-strings',
    '-Wpointer-arith',
    '-Wunused-local-typedefs',
    '-Wunused-result',
    '-Wvarargs',
    '-Wvla',  # variable-length array
    '-Wwrite-strings',
]

GCC_TEST_FLAGS = [
    '-Wno-conversion-null',
    '-Wno-missing-declarations',
    '-Wno-sign-compare',
    '-Wno-unused-function',
    '-Wno-unused-parameter',
    '-Wno-unused-private-field',
]


# Docs on single flags is preceded by a comment.
# Docs on groups of flags is preceded by ###.

LLVM_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Weverything',
    # Abseil does not support C++98
    '-Wno-c++98-compat-pedantic',
    '-Wno-comma',
    # Turns off all implicit conversion warnings. Most are re-enabled below.
    '-Wno-conversion',
    '-Wno-covered-switch-default',
    '-Wno-deprecated',
    '-Wno-disabled-macro-expansion',
    '-Wno-documentation',
    '-Wno-documentation-unknown-command',
    '-Wno-double-promotion',
    '-Wno-exit-time-destructors',
    '-Wno-extra-semi',
    '-Wno-float-conversion',
    '-Wno-float-equal',
    '-Wno-format-nonliteral',
    # Too aggressive: warns on Clang extensions enclosed in Clang-only code paths.
    '-Wno-gcc-compat',
    '-Wno-global-constructors',
    '-Wno-nested-anon-types',
    '-Wno-non-modular-include-in-module',
    '-Wno-old-style-cast',
    '-Wno-packed',
    '-Wno-padded',
    # Warns on preferred usage of non-POD types such as string_view
    '-Wno-range-loop-analysis',
    '-Wno-reserved-id-macro',
    '-Wno-shorten-64-to-32',
    '-Wno-sign-conversion',
    '-Wno-switch-enum',
    '-Wno-thread-safety-negative',
    '-Wno-undef',
    '-Wno-unknown-warning-option',
    '-Wno-unreachable-code',
    # Causes warnings on include guards
    '-Wno-unused-macros',
    '-Wno-weak-vtables',
    ###
    # Implicit conversion warnings turned off by -Wno-conversion
    # which are re-enabled below.
    '-Wbitfield-enum-conversion',
    '-Wbool-conversion',
    '-Wconstant-conversion',
    '-Wenum-conversion',
    '-Wint-conversion',
    '-Wliteral-conversion',
    '-Wnon-literal-null-conversion',
    '-Wnull-conversion',
    '-Wobjc-literal-conversion',
    '-Wstring-conversion',
    ###
]

LLVM_TEST_FLAGS = [
    '-Wno-c99-extensions',
    '-Wno-missing-noreturn',
    '-Wno-missing-prototypes',
    '-Wno-null-conversion',
    '-Wno-shadow',
    '-Wno-shift-sign-overflow',
    '-Wno-sign-compare',
    '-Wno-unused-function',
    '-Wno-unused-member-function',
    '-Wno-unused-parameter',
    '-Wno-unused-private-field',
    '-Wno-unused-template',
    '-Wno-used-but-marked-unused',
    '-Wno-zero-as-null-pointer-constant',
]

MSVC_FLAGS = [
    '/W3',
    '/WX',
    '/wd4005',  # macro-redifinition
    '/wd4068',  # unknown pragma
    '/wd4244',  # conversion from 'type1' to 'type2', possible loss of data
    '/wd4267',  # conversion from 'size_t' to 'type', possible loss of data
    '/wd4800',  # forcing value to bool 'true' or 'false' (performance warning)
    '/DNOMINMAX',  # Don't define min and max macros (windows.h)
    '/DWIN32_LEAN_AND_MEAN',  # Don't bloat namespace with incompatible winsock versions.
    '/D_CRT_SECURE_NO_WARNINGS',  # Don't warn about usage of insecure C functions
]

MSVC_TEST_FLAGS = [
    '/wd4018',  # signed/unsigned mismatch
    '/wd4101',  # unreferenced local variable
    '/wd4503',  # decorated name length exceeded, name was truncated
]

# /Wall with msvc includes unhelpful warnings such as C4711, C4710, ...
ABSL_DEFAULT_COPTS = select({
    ':windows': MSVC_FLAGS,
    ':llvm_compiler': LLVM_FLAGS,
    '//conditions:default': GCC_FLAGS,
})

# in absence of modules (--compiler=gcc or -c opt), cc_tests leak their copts
# to their (included header) dependencies and fail to build outside absl
ABSL_TEST_COPTS = ABSL_DEFAULT_COPTS + select({
    ':windows': MSVC_TEST_FLAGS,
    ':llvm_compiler': LLVM_TEST_FLAGS,
    '//conditions:default': GCC_TEST_FLAGS,
})

ABSL_EXCEPTIONS_FLAG = select({
    ':windows': ['/U_HAS_EXCEPTIONS', '/D_HAS_EXCEPTIONS=1', '/EHsc'],
    '//conditions:default': ['-fexceptions'],
})

#abseil-cpp/absl/time/BUILD.bazel.orig

absl_cc_library(
    name = 'time',
    srcs = [
        'absl/time/clock.cc',
        'absl/time/duration.cc',
        'absl/time/format.cc',
        'absl/time/internal/get_current_time_ios.inc',
        'absl/time/internal/get_current_time_posix.inc',
        'absl/time/internal/get_current_time_windows.inc',
        'absl/time/time.cc',
    ],
    hdrs = [
        'absl/time/clock.h',
        'absl/time/time.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base',
        ':base_core_headers',
        ':numeric_int128',
        '//third_party/cctz:civil_time',
        '//third_party/cctz:time_zone',
    ],
)

absl_cc_library(
    name = 'time_test_util',
    srcs = [
        'absl/time/internal/test_util.cc',
        'absl/time/internal/zoneinfo.inc',
    ],
    hdrs = ['absl/time/internal/test_util.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':time',
        ':base',
        '//third_party/cctz:time_zone',
    ],
)

cc_test(
    name = 'time_test',
    srcs = [
        'absl/time/clock_test.cc',
        'absl/time/duration_test.cc',
        'absl/time/format_test.cc',
        'absl/time/time_norm_test.cc',
        'absl/time/time_test.cc',
        'absl/time/time_zone_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    tags = [
        'no_test_android_arm',
        'no_test_android_arm64',
        'no_test_android_x86',
        'no_test_ios_x86_64',
        'no_test_loonix',
    ],
    deps = [
        ':time_test_util',
        ':time',
        ':base',
        ':base_config',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
        '//third_party/cctz:time_zone',
    ],
)

# abseil-cpp/absl/synchronization/BUILD.bazel.orig

# Internal data structure for efficiently detecting mutex dependency cycles
absl_cc_library(
    name = 'synchronization_graphcycles_internal',
    srcs = [
        'absl/synchronization/internal/graphcycles.cc',
    ],
    hdrs = [
        'absl/synchronization/internal/graphcycles.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    visibility = [
        '//visibility:__pkg__',
    ],
    deps = [
        ':base',
        ':base_core_headers',
        ':base_malloc_internal',
    ],
)

absl_cc_library(
    name = 'synchronization',
    srcs = [
        'absl/synchronization/barrier.cc',
        'absl/synchronization/blocking_counter.cc',
        'absl/synchronization/internal/create_thread_identity.cc',
        'absl/synchronization/internal/per_thread_sem.cc',
        'absl/synchronization/internal/waiter.cc',
        'absl/synchronization/notification.cc',
    ] + select({
        '//conditions:default': ['absl/synchronization/mutex.cc'],
    }),
    hdrs = [
        'absl/synchronization/barrier.h',
        'absl/synchronization/blocking_counter.h',
        'absl/synchronization/internal/create_thread_identity.h',
        'absl/synchronization/internal/kernel_timeout.h',
        'absl/synchronization/internal/mutex_nonprod.inc',
        'absl/synchronization/internal/per_thread_sem.h',
        'absl/synchronization/internal/waiter.h',
        'absl/synchronization/mutex.h',
        'absl/synchronization/notification.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':synchronization_graphcycles_internal',
        ':base',
        ':base_internal',
        ':base_config',
        ':base_core_headers',
        ':base_dynamic_annotations',
        ':base_malloc_extension',
        ':base_malloc_internal',
        ':debugging_stacktrace',
        ':time',
    ],
)

cc_test(
    name = 'synchronization_barrier_test',
    size = 'small',
    srcs = ['absl/synchronization/barrier_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization',
        ':time',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'synchronization_blocking_counter_test',
    size = 'small',
    srcs = ['absl/synchronization/blocking_counter_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization',
        ':time',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'synchronization_graphcycles_test',
    size = 'medium',
    srcs = ['absl/synchronization/internal/graphcycles_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization_graphcycles_internal',
        ':base',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'synchronization_thread_pool',
    testonly = 1,
    hdrs = ['absl/synchronization/internal/thread_pool.h'],
    deps = [
        ':synchronization',
        ':base_core_headers',
    ],
)

cc_test(
    name = 'synchronization_mutex_test',
    size = 'large',
    srcs = ['absl/synchronization/mutex_test.cc'],
    copts = ABSL_TEST_COPTS,
    tags = [
        'no_test_loonix',  # Too slow.
    ],
    deps = [
        ':synchronization',
        ':synchronization_thread_pool',
        ':base',
        ':base_core_headers',
        ':memory',
        ':time',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'synchronizatio_notification_test',
    size = 'small',
    srcs = ['absl/synchronization/notification_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization',
        ':time',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'synchronization_per_thread_sem_test_common',
    testonly = 1,
    srcs = ['absl/synchronization/internal/per_thread_sem_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization',
        ':base',
        ':base_malloc_extension',
        ':strings',
        ':time',
        '//third_party/gtest:gtest',
    ],
    alwayslink = 1,
)

cc_test(
    name = 'synchronization_per_thread_sem_test',
    size = 'medium',
    copts = ABSL_TEST_COPTS,
    deps = [
        ':synchronization_per_thread_sem_test_common',
        ':synchronization',
        ':base',
        ':base_malloc_extension',
        ':strings',
        ':time',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'synchronization_lifetime_test',
    srcs = [
        'absl/synchronization/lifetime_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    linkopts = select({
        ':windows': [],
        '//conditions:default': ['-pthread'],
    }),
    deps = [
        ':synchronization',
        ':base',
        ':base_core_headers',
    ],
)

# abseil-cpp/absl/memory/BUILD.bazel.orig

absl_cc_library(
    name = 'memory',
    hdrs = ['absl/memory/memory.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_core_headers',
        ':meta_type_traits',
    ],
)

cc_test(
    name = 'memory_memory_test',
    srcs = ['absl/memory/memory_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':memory',
        ':base',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/numeric/BUILD.bazel.orig

absl_cc_library(
    name = 'numeric_int128',
    srcs = [
        'absl/numeric/int128.cc',
        'absl/numeric/int128_have_intrinsic.inc',
        'absl/numeric/int128_no_intrinsic.inc',
    ],
    hdrs = ['absl/numeric/int128.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_config',
        ':base_core_headers',
    ],
)

cc_test(
    name = 'numeric_int128_test',
    size = 'small',
    srcs = [
        'absl/numeric/int128_stream_test.cc',
        'absl/numeric/int128_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':numeric_int128',
        ':base',
        ':base_core_headers',
        ':meta_type_traits',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/types/BUILD.bazel.orig

absl_cc_library(
    name = 'types_any',
    hdrs = ['absl/types/any.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':types_bad_any_cast',
        ':base_config',
        ':base_core_headers',
        ':meta_type_traits',
        ':utility',
    ],
)

absl_cc_library(
    name = 'types_bad_any_cast',
    srcs = ['absl/types/bad_any_cast.cc'],
    hdrs = ['absl/types/bad_any_cast.h'],
    copts = ABSL_EXCEPTIONS_FLAG + ABSL_DEFAULT_COPTS,
    deps = [
        ':base',
        ':base_config',
    ],
)

cc_test(
    name = 'types_any_test',
    size = 'small',
    srcs = [
        'absl/types/any_test.cc',
    ],
    copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':types_any',
        ':base',
        ':base_config',
        ':base_exception_testing',
        ':container_test_instance_tracker',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'types_any_test_noexceptions',
    size = 'small',
    srcs = [
        'absl/types/any_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':types_any',
        ':base',
        ':base_config',
        ':base_exception_testing',
        ':container_test_instance_tracker',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'types_span',
    hdrs = ['absl/types/span.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':algorithm',
        ':base_core_headers',
        ':base_throw_delegate',
        ':meta_type_traits',
    ],
)

cc_test(
    name = 'types_span_test',
    size = 'small',
    srcs = ['absl/types/span_test.cc'],
    copts = ABSL_TEST_COPTS + ['-fexceptions'],
    deps = [
        ':types_span',
        ':base_config',
        ':base_core_headers',
        ':base_exception_testing',
        ':container_fixed_array',
        ':container_inlined_vector',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'types_span_test_noexceptions',
    size = 'small',
    srcs = ['absl/types/span_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':types_span',
        ':base_config',
        ':base_core_headers',
        ':base_exception_testing',
        ':container_fixed_array',
        ':container_inlined_vector',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'types_optional',
    srcs = ['absl/types/optional.cc'],
    hdrs = ['absl/types/optional.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':types_bad_optional_access',
        ':base_config',
        ':memory',
        ':meta_type_traits',
        ':utility',
    ],
)

absl_cc_library(
    name = 'types_bad_optional_access',
    srcs = ['absl/types/bad_optional_access.cc'],
    hdrs = ['absl/types/bad_optional_access.h'],
    copts = ABSL_DEFAULT_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':base',
        ':base_config',
    ],
)

cc_test(
    name = 'types_optional_test',
    size = 'small',
    srcs = [
        'absl/types/optional_test.cc',
    ],
    copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':types_optional',
        ':base',
        ':base_config',
        ':meta_type_traits',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/algorithm/BUILD.bazel.orig

absl_cc_library(
    name = 'algorithm',
    hdrs = ['absl/algorithm/algorithm.h'],
    copts = ABSL_DEFAULT_COPTS,
)

cc_test(
    name = 'algorithm_algorithm_test',
    size = 'small',
    srcs = ['absl/algorithm/algorithm_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':algorithm',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'algorithm_container',
    hdrs = [
        'absl/algorithm/container.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':algorithm',
        ':base_core_headers',
        ':meta_type_traits',
    ],
)

cc_test(
    name = 'algorithm_container_test',
    srcs = ['absl/algorithm/container_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':algorithm_container',
        ':base',
        ':base_core_headers',
        ':memory',
        ':types_span',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/meta/BUILD.bazel.orig

absl_cc_library(
    name = 'meta_type_traits',
    hdrs = ['absl/meta/type_traits.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_config',
    ],
)

cc_test(
    name = 'meta_type_traits_test',
    srcs = ['absl/meta/type_traits_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':meta_type_traits',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/base/BUILD.bazel.orig

absl_cc_library(
    name = 'base_spinlock_wait',
    srcs = [
        'absl/base/internal/spinlock_akaros.inc',
        'absl/base/internal/spinlock_posix.inc',
        'absl/base/internal/spinlock_wait.cc',
        'absl/base/internal/spinlock_win32.inc',
    ],
    hdrs = [
        'absl/base/internal/scheduling_mode.h',
        'absl/base/internal/spinlock_wait.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    visibility = [
        '//visibility:__pkg__',
    ],
    deps = [':base_core_headers'],
)

absl_cc_library(
    name = 'base_config',
    hdrs = [
        'absl/base/config.h',
        'absl/base/policy_checks.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
)

absl_cc_library(
    name = 'base_dynamic_annotations',
    srcs = ['absl/base/dynamic_annotations.cc'],
    hdrs = ['absl/base/dynamic_annotations.h'],
    copts = ABSL_DEFAULT_COPTS,
    defines = ['__CLANG_SUPPORT_DYN_ANNOTATION__'],
)

absl_cc_library(
    name = 'base_core_headers',
    hdrs = [
        'absl/base/attributes.h',
        'absl/base/macros.h',
        'absl/base/optimization.h',
        'absl/base/port.h',
        'absl/base/thread_annotations.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_config',
        ':base_dynamic_annotations',
    ],
)

absl_cc_library(
    name = 'base_malloc_extension',
    srcs = ['absl/base/internal/malloc_extension.cc'],
    hdrs = [
        'absl/base/internal/malloc_extension.h',
        'absl/base/internal/malloc_extension_c.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    visibility = [
        '//visibility:__pkg__',
    ],
    deps = [
        ':base_core_headers',
        ':base_dynamic_annotations',
    ],
)

# base_malloc_extension feels like it wants to be folded into this target, but
# base_malloc_internal gets special build treatment to compile at -O3, so these
# need to stay separate.
absl_cc_library(
    name = 'base_malloc_internal',
    srcs = [
        'absl/base/internal/low_level_alloc.cc',
        'absl/base/internal/malloc_hook.cc',
        'absl/base/internal/malloc_hook_mmap_linux.inc',
    ],
    hdrs = [
        'absl/base/internal/low_level_alloc.h',
        'absl/base/internal/malloc_hook.h',
        'absl/base/internal/malloc_hook_c.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    textual_hdrs = [
        'absl/base/internal/malloc_hook_invoke.h',
    ],
    visibility = [
        '//visibility:__pkg__',
    ],
    deps = [
        ':base',
        ':base_config',
        ':base_core_headers',
        ':base_dynamic_annotations',
        ':base_spinlock_wait',
    ],
)

absl_cc_library(
    name = 'base_internal',
    hdrs = [
        'absl/base/internal/identity.h',
        'absl/base/internal/invoke.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    visibility = [
        '//visibility:__pkg__',
    ],
)

absl_cc_library(
    name = 'base',
    srcs = [
        'absl/base/internal/cycleclock.cc',
        'absl/base/internal/raw_logging.cc',
        'absl/base/internal/spinlock.cc',
        'absl/base/internal/sysinfo.cc',
        'absl/base/internal/thread_identity.cc',
        'absl/base/internal/unscaledcycleclock.cc',
    ],
    hdrs = [
        'absl/base/call_once.h',
        'absl/base/casts.h',
        'absl/base/internal/atomic_hook.h',
        'absl/base/internal/cycleclock.h',
        'absl/base/internal/log_severity.h',
        'absl/base/internal/low_level_scheduling.h',
        'absl/base/internal/per_thread_tls.h',
        'absl/base/internal/raw_logging.h',
        'absl/base/internal/spinlock.h',
        'absl/base/internal/sysinfo.h',
        'absl/base/internal/thread_identity.h',
        'absl/base/internal/tsan_mutex_interface.h',
        'absl/base/internal/unscaledcycleclock.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_internal',
        ':base_config',
        ':base_core_headers',
        ':base_dynamic_annotations',
        ':base_spinlock_wait',
    ],
)

cc_test(
    name = 'base_bit_cast_test',
    size = 'small',
    srcs = [
        'absl/base/bit_cast_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'base_throw_delegate',
    srcs = ['absl/base/internal/throw_delegate.cc'],
    hdrs = ['absl/base/internal/throw_delegate.h'],
    copts = ABSL_DEFAULT_COPTS + ABSL_EXCEPTIONS_FLAG,
    visibility = [
        '//visibility:__pkg__',
    ],
    deps = [
        ':base',
        ':base_config',
        ':base_core_headers',
    ],
)

cc_test(
    name = 'base_throw_delegate_test',
    srcs = ['absl/base/throw_delegate_test.cc'],
    copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':base_throw_delegate',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'base_exception_testing',
    testonly = 1,
    hdrs = ['absl/base/internal/exception_testing.h'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:__pkg__'],
    deps = [
        ':base_config',
        '//third_party/gtest:gtest',
    ],
)

absl_cc_library(
    name = 'base_pretty_function',
    hdrs = ['absl/base/internal/pretty_function.h'],
    visibility = ['//visibility:__pkg__'],
)

absl_cc_library(
    name = 'base_exception_safety_testing',
    testonly = 1,
    srcs = ['absl/base/internal/exception_safety_testing.cc'],
    hdrs = ['absl/base/internal/exception_safety_testing.h'],
    copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':base_config',
        ':base_pretty_function',
        ':memory',
        ':meta_type_traits',
        ':strings',
        ':types_optional',
        '//third_party/gtest:gtest',
    ],
)

cc_test(
    name = 'base_exception_safety_testing_test',
    srcs = ['absl/base/exception_safety_testing_test.cc'],
    copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    deps = [
        ':base_exception_safety_testing',
        ':memory',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_invoke_test',
    size = 'small',
    srcs = ['absl/base/invoke_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base_internal',
        ':memory',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

# Common test library made available for use in non-absl code that overrides
# AbslInternalSpinLockDelay and AbslInternalSpinLockWake.
absl_cc_library(
    name = 'base_spinlock_test_common',
    testonly = 1,
    srcs = ['absl/base/spinlock_test_common.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':base_core_headers',
        ':base_spinlock_wait',
        ':synchronization',
        '//third_party/gtest:gtest',
    ],
    alwayslink = 1,
)

cc_test(
    name = 'base_spinlock_test',
    size = 'medium',
    srcs = ['absl/base/spinlock_test_common.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':base_core_headers',
        ':base_spinlock_wait',
        ':synchronization',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'base_endian',
    hdrs = [
        'absl/base/internal/endian.h',
        'absl/base/internal/unaligned_access.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_config',
        ':base_core_headers',
    ],
)

cc_test(
    name = 'base_endian_test',
    srcs = ['absl/base/internal/endian_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':base_config',
        ':base_endian',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_config_test',
    srcs = ['absl/base/config_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base_config',
        ':synchronization_thread_pool',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_call_once_test',
    srcs = ['absl/base/call_once_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':base_core_headers',
        ':synchronization',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_raw_logging_test',
    srcs = ['absl/base/raw_logging_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_sysinfo_test',
    size = 'small',
    srcs = ['absl/base/internal/sysinfo_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':base',
        ':synchronization',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_low_level_alloc_test',
    size = 'small',
    srcs = ['absl/base/internal/low_level_alloc_test.cc'],
    copts = ABSL_TEST_COPTS,
    linkopts = select({
        ':windows': [],
        '//conditions:default': ['-pthread'],
    }),
    deps = [':base_malloc_internal'],
)

cc_test(
    name = 'base_thread_identity_test',
    size = 'small',
    srcs = ['absl/base/internal/thread_identity_test.cc'],
    copts = ABSL_TEST_COPTS,
    linkopts = select({
        ':windows': [],
        '//conditions:default': ['-pthread'],
    }),
    deps = [
        ':base',
        ':base_core_headers',
        ':synchronization',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'base_malloc_extension_system_malloc_test',
    size = 'small',
    srcs = ['absl/base/internal/malloc_extension_test.cc'],
    copts = select({
        ':windows': [
            '/DABSL_MALLOC_EXTENSION_TEST_ALLOW_MISSING_EXTENSION=1',
        ],
        '//conditions:default': [
            '-DABSL_MALLOC_EXTENSION_TEST_ALLOW_MISSING_EXTENSION=1',
        ],
    }) + ABSL_TEST_COPTS,
    features = [
        # This test can't be run under lsan because the test requires system
        # malloc, and lsan provides a competing malloc implementation.
        '-leak_sanitize',
    ],
    deps = [
        ':base_malloc_extension',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/container/BUILD.bazel.orig

absl_cc_library(
    name = 'container_fixed_array',
    hdrs = ['absl/container/fixed_array.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':algorithm',
        ':base_core_headers',
        ':base_dynamic_annotations',
        ':base_throw_delegate',
    ],
)

cc_test(
    name = 'container_fixed_array_test',
    srcs = ['absl/container/fixed_array_test.cc'],
    copts = ABSL_TEST_COPTS + ['-fexceptions'],
    deps = [
        ':container_fixed_array',
        ':base_core_headers',
        ':base_exception_testing',
        ':memory',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'container_fixed_array_test_noexceptions',
    srcs = ['absl/container/fixed_array_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':container_fixed_array',
        ':base_core_headers',
        ':base_exception_testing',
        ':memory',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'container_inlined_vector',
    hdrs = ['absl/container/inlined_vector.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':algorithm',
        ':base_core_headers',
        ':base_throw_delegate',
        ':memory',
    ],
)

cc_test(
    name = 'container_inlined_vector_test',
    srcs = ['absl/container/inlined_vector_test.cc'],
    copts = ABSL_TEST_COPTS + ['-fexceptions'],
    deps = [
        ':container_inlined_vector',
        ':container_test_instance_tracker',
        ':base',
        ':base_core_headers',
        ':base_exception_testing',
        ':memory',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'container_inlined_vector_test_noexceptions',
    srcs = ['absl/container/inlined_vector_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':container_inlined_vector',
        ':container_test_instance_tracker',
        ':base',
        ':base_core_headers',
        ':base_exception_testing',
        ':memory',
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

absl_cc_library(
    name = 'container_test_instance_tracker',
    testonly = 1,
    srcs = ['absl/container/internal/test_instance_tracker.cc'],
    hdrs = ['absl/container/internal/test_instance_tracker.h'],
    copts = ABSL_DEFAULT_COPTS,
    visibility = [
        '//visibility:__pkg__',
    ],
)

cc_test(
    name = 'container_test_instance_tracker_test',
    srcs = ['absl/container/internal/test_instance_tracker_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':container_test_instance_tracker',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/debugging/BUILD.bazel.orig

absl_cc_library(
    name = 'debugging_stacktrace',
    srcs = [
        'absl/debugging/stacktrace.cc',
    ],
    hdrs = ['absl/debugging/stacktrace.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':debugging_debugging_internal',
        ':base',
        ':base_core_headers',
    ],
)

absl_cc_library(
    name = 'debugging_debugging_internal',
    srcs = [
        'absl/debugging/internal/address_is_readable.cc',
        'absl/debugging/internal/elf_mem_image.cc',
        'absl/debugging/internal/vdso_support.cc',
    ],
    hdrs = [
        'absl/debugging/internal/address_is_readable.h',
        'absl/debugging/internal/elf_mem_image.h',
        'absl/debugging/internal/stacktrace_aarch64-inl.inc',
        'absl/debugging/internal/stacktrace_arm-inl.inc',
        'absl/debugging/internal/stacktrace_config.h',
        'absl/debugging/internal/stacktrace_generic-inl.inc',
        'absl/debugging/internal/stacktrace_powerpc-inl.inc',
        'absl/debugging/internal/stacktrace_unimplemented-inl.inc',
        'absl/debugging/internal/stacktrace_win32-inl.inc',
        'absl/debugging/internal/stacktrace_x86-inl.inc',
        'absl/debugging/internal/vdso_support.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base',
        ':base_dynamic_annotations',
        ':base_core_headers',
    ],
)

absl_cc_library(
    name = 'debugging_leak_check',
    srcs = select({
        # The leak checking interface depends on weak function
        # declarations that may not necessarily have definitions.
        # Windows doesn't support this, and ios requires
        # guaranteed definitions for weak symbols.
        ':ios': [],
        ':windows': [],
        '//conditions:default': [
            'absl/debugging/leak_check.cc',
        ],
    }),
    hdrs = select({
        ':ios': [],
        ':windows': [],
        '//conditions:default': ['absl/debugging/leak_check.h'],
    }),
    deps = [':base_core_headers'],
)

# Adding a dependency to leak_check_disable will disable
# sanitizer leak checking (asan/lsan) in a test without
# the need to mess around with build features.
absl_cc_library(
    name = 'debugging_leak_check_disable',
    srcs = ['absl/debugging/leak_check_disable.cc'],
    linkstatic = 1,
    alwayslink = 1,
)

# These targets exists for use in tests only, explicitly configuring the
# LEAK_SANITIZER macro. It must be linked with -fsanitize=leak for lsan.
ABSL_LSAN_LINKOPTS = select({
    ':llvm_compiler': ['-fsanitize=leak'],
    '//conditions:default': [],
})

absl_cc_library(
    name = 'debugging_leak_check_api_enabled_for_testing',
    testonly = 1,
    srcs = ['absl/debugging/leak_check.cc'],
    hdrs = ['absl/debugging/leak_check.h'],
    copts = select({
        ':llvm_compiler': ['-DLEAK_SANITIZER'],
        '//conditions:default': [],
    }),
    visibility = ['//visibility:private'],
)

absl_cc_library(
    name = 'debugging_leak_check_api_disabled_for_testing',
    testonly = 1,
    srcs = ['absl/debugging/leak_check.cc'],
    hdrs = ['absl/debugging/leak_check.h'],
    copts = ['-ULEAK_SANITIZER'],
    visibility = ['//visibility:private'],
)

cc_test(
    name = 'debugging_leak_check_test',
    srcs = ['absl/debugging/leak_check_test.cc'],
    copts = select({
        ':llvm_compiler': ['-DABSL_EXPECT_LEAK_SANITIZER'],
        '//conditions:default': [],
    }),
    linkopts = ABSL_LSAN_LINKOPTS,
    deps = [
        ':debugging_leak_check_api_enabled_for_testing',
        ':base',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'debugging_leak_check_no_lsan_test',
    srcs = ['absl/debugging/leak_check_test.cc'],
    copts = ['-UABSL_EXPECT_LEAK_SANITIZER'],
    deps = [
        ':debugging_leak_check_api_disabled_for_testing',
        ':base',  # for raw_logging
        '//third_party/gtest:gtest_main',
    ],
)

# Test that leak checking is skipped when lsan is enabled but
# ':leak_check_disable' is linked in.
#
# This test should fail in the absence of a dependency on ':leak_check_disable'
cc_test(
    name = 'debugging_disabled_leak_check_test',
    srcs = ['absl/debugging/leak_check_fail_test.cc'],
    linkopts = ABSL_LSAN_LINKOPTS,
    deps = [
        ':debugging_leak_check_api_enabled_for_testing',
        ':debugging_leak_check_disable',
        ':base',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/strings/BUILD.bazel.orig

absl_cc_library(
    name = 'strings',
    srcs = [
        'absl/strings/ascii.cc',
        'absl/strings/escaping.cc',
        'absl/strings/internal/memutil.cc',
        'absl/strings/internal/memutil.h',
        'absl/strings/internal/str_join_internal.h',
        'absl/strings/internal/str_split_internal.h',
        'absl/strings/match.cc',
        'absl/strings/numbers.cc',
        'absl/strings/str_cat.cc',
        'absl/strings/str_replace.cc',
        'absl/strings/str_split.cc',
        'absl/strings/string_view.cc',
        'absl/strings/substitute.cc',
    ],
    hdrs = [
        'absl/strings/ascii.h',
        'absl/strings/escaping.h',
        'absl/strings/match.h',
        'absl/strings/numbers.h',
        'absl/strings/str_cat.h',
        'absl/strings/str_join.h',
        'absl/strings/str_replace.h',
        'absl/strings/str_split.h',
        'absl/strings/string_view.h',
        'absl/strings/strip.h',
        'absl/strings/substitute.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':strings_internal',
        ':base',
        ':base_config',
        ':base_core_headers',
        ':base_endian',
        ':base_throw_delegate',
        ':memory',
        ':meta_type_traits',
        ':numeric_int128',
    ],
)

absl_cc_library(
    name = 'strings_internal',
    srcs = [
        'absl/strings/internal/ostringstream.cc',
        'absl/strings/internal/utf8.cc',
    ],
    hdrs = [
        'absl/strings/internal/char_map.h',
        'absl/strings/internal/ostringstream.h',
        'absl/strings/internal/resize_uninitialized.h',
        'absl/strings/internal/utf8.h',
    ],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_core_headers',
        ':base_endian',
        ':meta_type_traits',
    ],
)

cc_test(
    name = 'strings_match_test',
    size = 'small',
    srcs = ['absl/strings/match_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_escaping_test',
    size = 'small',
    srcs = [
        'absl/strings/escaping_test.cc',
        'absl/strings/internal/escaping_test_common.inc',
    ],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        ':container_fixed_array',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_ascii_test',
    size = 'small',
    srcs = ['absl/strings/ascii_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_memutil_test',
    size = 'small',
    srcs = [
        'absl/strings/internal/memutil.h',
        'absl/strings/internal/memutil_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_utf8_test',
    size = 'small',
    srcs = [
        'absl/strings/internal/utf8_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings_internal',
        ':strings',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

# The source does not compile due to the following issue:
#       https://github.com/abseil/abseil-cpp/issues/63
#cc_test(
    #name = 'strings_string_view_test',
    #size = 'small',
    #srcs = ['absl/strings/string_view_test.cc'],
    #copts = ABSL_TEST_COPTS + ABSL_EXCEPTIONS_FLAG,
    #visibility = ['//visibility:private'],
    #deps = [
        #':strings',
        #':base_config',
        #':base_core_headers',
        #':base_dynamic_annotations',
        #'//third_party/gtest:gtest_main',
    #],
#)

# This test fails due to a segfault.  See the issue at:
#       https://github.com/abseil/abseil-cpp/issues/64
cc_test(
    name = 'strings_substitute_test',
    size = 'small',
    srcs = ['absl/strings/substitute_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_str_replace_test',
    size = 'small',
    srcs = ['absl/strings/str_replace_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_str_split_test',
    srcs = ['absl/strings/str_split_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        ':base_dynamic_annotations',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_ostringstream_test',
    size = 'small',
    srcs = ['absl/strings/internal/ostringstream_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings_internal',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_resize_uninitialized_test',
    size = 'small',
    srcs = [
        'absl/strings/internal/resize_uninitialized.h',
        'absl/strings/internal/resize_uninitialized_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':base_core_headers',
        ':meta_type_traits',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_str_join_test',
    size = 'small',
    srcs = ['absl/strings/str_join_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        ':memory',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'stringsstr_cat_test',
    size = 'small',
    srcs = ['absl/strings/str_cat_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_numbers_test',
    size = 'small',
    srcs = [
        'absl/strings/internal/numbers_test_common.inc',
        'absl/strings/numbers_test.cc',
    ],
    copts = ABSL_TEST_COPTS,
    tags = [
        'no_test_loonix',
    ],
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        ':base',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_strip_test',
    size = 'small',
    srcs = ['absl/strings/strip_test.cc'],
    copts = ABSL_TEST_COPTS,
    visibility = ['//visibility:private'],
    deps = [
        ':strings',
        '//third_party/gtest:gtest_main',
    ],
)

cc_test(
    name = 'strings_char_map_test',
    srcs = ['absl/strings/internal/char_map_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':strings_internal',
        '//third_party/gtest:gtest_main',
    ],
)

# abseil-cpp/absl/utility/BUILD.bazel.orig

absl_cc_library(
    name = 'utility',
    srcs = ['absl/utility/utility.cc'],
    hdrs = ['absl/utility/utility.h'],
    copts = ABSL_DEFAULT_COPTS,
    deps = [
        ':base_config',
        ':meta_type_traits',
    ],
)

cc_test(
    name = 'utility_utility_test',
    srcs = ['absl/utility/utility_test.cc'],
    copts = ABSL_TEST_COPTS,
    deps = [
        ':utility',
        ':base_core_headers',
        '//third_party/gtest:gtest_main',
    ],
)
