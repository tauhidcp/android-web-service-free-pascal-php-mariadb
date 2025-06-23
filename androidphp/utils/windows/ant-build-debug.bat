set Path=%PATH%;D:\Master\Android\apache-ant-1.10.14
set JAVA_HOME=C:\Program Files\Zulu\zulu-21
cd D:\android-web-service-php-mariadb\androidphp\utils\windows\
call ant clean -Dtouchtest.enabled=true debug
if errorlevel 1 pause
