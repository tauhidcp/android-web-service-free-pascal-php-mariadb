set JAVA_HOME=C:\Program Files\Zulu\zulu-21
path %JAVA_HOME%\bin;%path%
cd D:\android-web-service-php-mariadb\androidphp\utils\windows\
jarsigner -verify -verbose -certs D:\android-web-service-php-mariadb\androidphp\build\outputs\apk\release\androidphp-release.apk
