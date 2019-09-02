#!/bin/bash
grep  -vE "(ios|windows|test|\<out\>|\<chromeos\>|printing|\<cocoa\>|\<ash\>|\<mac\>|\<win\>|\<elfutils\>|\<third_party\>|\<v8\>|\<build\>|\<breakpad\>|\<native_client\>|\<pdf\>|\<extensions\>|\<native_client_sdk\>|\<chromecast\>|\<ppapi\>|\<google_apis\>)"
