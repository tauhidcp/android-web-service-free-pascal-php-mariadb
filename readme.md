# Android Web Service Menggunakan Free Pascal + PHP + MariaDB

Aplikasi Web Service Sederhana Menggunakan Lazarus Free Pascal + PHP dan Database MariaDB. Secara umum, aplikasi memiliki kemampuan untuk mengambil dan mengolah data JSON dari server meliputi sbb:

- Mengambil data JSON dari PHP dan menampilkannya ke dalam ListView Android
- Mengirimkan Data dari Android Menggunakan Free Pascal untuk selanjutnya diproses oleh PHP (Insert, Update dan Delete) ke dalam Database MariaDB
- Fitur Upload dan Download File

## Tools Pendukung
- Windows 11 64
- Lazarus 3.6 + FPC 3.2.2 + LAMW 0.8.6.4 (dipasang menggunakan tools **fpcupdeluxe**)
- Apache-ant-1.10.14
- Gradle 8.5.0
- XAMPP (PHP 8.2.4 and MariaDB 10.4.28)
- Java 21 (Zulu), set JAVA_HOME pada saat instalasi
- Android NDK r22b (versi yang lebih tinggi perlu melakukan build toolchains secara mandiri)
- Android SDK (diperoleh melalui android studio/install platform, platform tools dan build tools yang diperlukan setidaknya versi >=33 yang disyaratkan oleh Google Play Service)
- Xiaomi Redmi Note 9 / Android 12 (mode USB debug)
- **Nonaktifkan firewall agar koneksi dari Android tidak diblok oleh Windows**
