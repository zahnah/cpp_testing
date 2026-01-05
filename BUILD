# In a directory like //my_project/my_lib
cc_library(
    name = "my_lib",
    srcs = ["utils.cpp"],
    hdrs = ["utils.h"],
    visibility = ["//visibility:public"],
)

cc_test(
    name = "utils_test",
    size = "small",
    srcs = ["utils_test.cpp"],
    deps = [
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        ":my_lib"
    ],
)