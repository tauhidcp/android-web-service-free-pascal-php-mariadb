set Path=%PATH%;D:\Master\Android\Sdk\platform-tools;D:\Master\Android\Sdk\build-tools\30.0.3
set GRADLE_HOME=D:\Master\Android\gradle-8.5
set PATH=%PATH%;%GRADLE_HOME%\bin
zipalign -v -p 4 D:\android-web-service-php-mariadb\androidphp\build\outputs\apk\release\androidphp-universal-release-unsigned.apk D:\android-web-service-php-mariadb\androidphp\build\outputs\apk\release\androidphp-universal-release-unsigned-aligned.apk
apksigner sign --ks D:\android-web-service-php-mariadb\androidphp\androidphp-release.keystore --ks-pass pass:123456 --key-pass pass:123456 --out D:\android-web-service-php-mariadb\androidphp\build\outputs\apk\release\androidphp-release.apk D:\android-web-service-php-mariadb\androidphp\build\outputs\apk\release\androidphp-universal-release-unsigned-aligned.apk
