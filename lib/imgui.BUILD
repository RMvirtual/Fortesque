load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "imgui",
    srcs = glob([
        "*.cpp",
        "backends/*.cpp",
    ]),
    hdrs = glob([
        "*.h",
        "backends/*.h",
    ]),
    linkopts = [
        "-lglfw",
        "-lGLEW",
        "-lGLU",
        "-lGL",
        "-lglut",
        "-lsfml-graphics",
        "-lsfml-window",
        "-lsfml-system",
    ],
    visibility = ["//visibility:public"],
)