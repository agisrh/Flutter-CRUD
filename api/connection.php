<?php
define('HOSTNAME','localhost'); // nama host atau domain
define('USERNAME','root'); // username akses database
define('PASSWORD',''); // password akses database
define('DB_NAME','db_mahasiswa'); // nama database

$koneksi = new mysqli(HOSTNAME, USERNAME, PASSWORD, DB_NAME) or die (mysqli_errno()); // koneksi
?>