export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd D:\android-web-service-php-mariadb\androidphp\utils\unix\
keytool -genkey -v -keystore androidphp-release.keystore -alias androidphp.keyalias -keyalg RSA -keysize 2048 -validity 10000 < /android-web-service-php-mariadb/androidphp/keytool_input.txt
