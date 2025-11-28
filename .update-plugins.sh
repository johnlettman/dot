#!/bin/sh
git pull --recurse-submodules --jobs "$(getconf _NPROCESSORS_ONLN)"
git submodule update
