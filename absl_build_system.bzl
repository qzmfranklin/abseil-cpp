def absl_cc_library(name, srcs=[], hdrs=[], textual_hdrs=[], includes=[],
                    defines=[], copts=[], linkopts=[], deps = [], alwayslink=0,
                    linkstatic=0, visibility = ['//visibility:public'], testonly=0):
    if native.package_name():
        real_includes = includes + [ '.' ]
        real_copts = copts
        real_linkopts = linkopts + [ '-lm' ]
    else:
        real_includes = includes
        real_copts = copts
        real_linkopts = linkopts
    native.cc_library(
        name = name,
        srcs = srcs,
        hdrs = hdrs,
        textual_hdrs = textual_hdrs,
        includes = real_includes,
        defines = defines,
        copts = real_copts,
        linkopts = real_linkopts,
        deps = deps,
        alwayslink = alwayslink,
        linkstatic = linkstatic,
        visibility = visibility,
        testonly = testonly,
    )
