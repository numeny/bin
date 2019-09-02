#!/bin/bash
adb shell "su -c '/data/bdg/gdbserver :5039 --attach `adb shell ps | grep "explorer.demo" | awk '{print $2}'`'"
