export JAVA_HOME=/Program Files/Zulu/zulu-21
cd /android-web-service-php-mariadb/androidphp
LC_ALL=C keytool -genkey -v -keystore androidphp-release.keystore -alias androidphp.keyalias -keyalg RSA -keysize 2048 -validity 10000 < /android-web-service-php-mariadb/androidphp/keytool_input.txt
