export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd D:\android-web-service-php-mariadb\androidphp\utils\unix\
jarsigner -verify -verbose -certs /android-web-service-php-mariadb/androidphp/bin/androidphp-release.apk
