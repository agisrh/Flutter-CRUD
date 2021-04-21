<?php
header('Content-Type: application/json');
include_once('connection.php');

// Jika semua data yg dikirim ada, maka proses request user
if (isset($_POST['npm']) && isset($_POST['npm']) && isset($_POST['prodi']) && isset($_POST['fakultas']))
{

    // variable data yg dikirim dan lakukan filter agar tidak ada tag HTMl yg dikirim
    $npm      = htmlentities($_POST['npm']);
    $nama     = htmlentities($_POST['nama']);
    $prodi    = htmlentities($_POST['prodi']);
    $fakultas = htmlentities($_POST['fakultas']);

    // Insert data ke dalam database
    $query = "INSERT INTO mahasiswa(npm,nama,prodi,fakultas) VALUES ('$npm','$nama','$prodi','$fakultas')";
    $insert = mysqli_query($koneksi,$query);
    $response = array();
    
    // Jika sukses beri respon pesan berhasil
    if($insert)
    {
    $response['status'] = 200;
    $response['message'] = "Data berhasil disimpan !";

    // Jika gagal beri respon pesan gagal
    }else{
    $response['status'] = 409;
    $response['message'] = "Data gagal disimpan !";
    }

// Jika tidak ada data yg dikrim beri pesan
}else{
    $response['status'] = 400;
    $response['message'] = "Permintaan tidak sesuai !";
}

echo json_encode($response);
?>