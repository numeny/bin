#/bin/bash
SOGOULIB_PATH=out/target/product/generic/system/lib/
ANDROID_PATH=`pwd`
ls -l ${ANDROID_PATH}/${SOGOULIB_PATH}/libsogousupport.so
ls -l ${ANDROID_PATH}/${SOGOULIB_PATH}/libsogouwebcore.so
echo "${ANDROID_PATH}"
cp ${ANDROID_PATH}/${SOGOULIB_PATH}/libsogousupport.so /var/www/huawei
cp ${ANDROID_PATH}/${SOGOULIB_PATH}/libsogouwebcore.so /var/www/huawei
ls -l /var/www/huawei/
