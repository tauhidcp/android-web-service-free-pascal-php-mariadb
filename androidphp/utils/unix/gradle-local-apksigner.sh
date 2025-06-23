export PATH=/Master/Android/Sdk/platform-tools:$PATH
export PATH=/Master/Android/Sdk/build-tools/30.0.3:$PATH
export GRADLE_HOME=/Master/Android/gradle-8.5
export PATH=$PATH:$GRADLE_HOME/bin
zipalign -v -p 4 /android-web-service-php-mariadb/androidphp/build/outputs/apk/release/androidphp-armeabi-v7a-release-unsigned.apk /android-web-service-php-mariadb/androidphp/build/outputs/apk/release/androidphp-armeabi-v7a-release-unsigned-aligned.apk
apksigner sign --ks /android-web-service-php-mariadb/androidphp/androidphp-release.keystore --ks-pass pass:123456 --key-pass pass:123456 --out /android-web-service-php-mariadb/androidphp/build/outputs/apk/release/androidphp-release.apk /android-web-service-php-mariadb/androidphp/build/outputs/apk/release/androidphp-armeabi-v7a-release-unsigned-aligned.apk
