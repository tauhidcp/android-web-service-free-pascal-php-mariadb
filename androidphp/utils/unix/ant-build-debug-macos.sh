export PATH=/Master/Android/apache-ant-1.10.14:$PATH
export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd D:\android-web-service-php-mariadb\androidphp\utils\unix\
ant -Dtouchtest.enabled=true debug
