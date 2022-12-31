load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "main",
    srcs = glob([
        "*.cpp",
        "backends/*.cpp",
    ]),
    hdrs = glob([
        "*.h",
        "backends/*.h",
    ]),
    linkopts = [],
    visibility = ["//visibility:public"]
)