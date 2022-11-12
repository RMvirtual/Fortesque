cls
@echo off
bazel test --test_output=all --test_summary=detailed //...
@echo on