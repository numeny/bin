#!/bin/bash
build/android/adb_gdb --symbol-dir=out/Release/lib.unstripped/ --output-directory=out/Release/ --package-name=sogou.mobile.explorer --activity=BrowserActivity
