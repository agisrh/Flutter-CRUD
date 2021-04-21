<?php
header('Content-Type: application/json');
require_once('connection.php');

// Jika semua data yg dikirim ada, maka proses request user
if (isset($_POST['npm']) && isset($_POST['npm']) && isset($_POST['prodi']) && isset($_POST['fakultas']))
{
    // variable data yg dikirim dan lakukan filter agar tidak ada tag HTMl yg dikirim
    $npm      = htmlentities($_POST['npm']);
    $nama     = htmlentities($_POST['nama']);
    $prodi    = htmlentities($_POST['prodi']);
    $fakultas = htmlentities($_POST['fakultas']);

    // Cek apakah data yg dikirim sudah ada di database
    $cekdata = mysqli_query($koneksi,"SELECT * FROM mahasiswa WHERE npm='$npm'");
    $rows    = mysqli_num_rows($cekdata);
    $update  = "UPDATE mahasiswa SET nama='$nama',prodi='$prodi',fakultas='$fakultas' WHERE npm='$npm'";
    $query   = mysqli_query($koneksi,$update);

    // variable response status
    $respose = array();

    // Jika data ada, maka lakukan proses selanjutnya
    if($rows > 0)
    {
        // Jika query update berhasil, beri pesan sukses
        if($query)
        {
            $respose['status']  = 200;
            $respose['message'] = "Data berhasil di perbaharui !";
        }else{
            $respose['status']  = 409;
            $respose['message'] = "Data gagal di perbaharui !";
        }
    
    // jika data tidak ada dalam database
    }else{
        $respose['status'] = 404;
        $respose['message'] = "Data tidak di temukan !";
    }
// Jika tidak ada data yg dikrim beri pesan
}else{
    $response['status'] = 400;
    $response['message'] = "Permintaan tidak sesuai !";
}
echo json_encode($respose);
?>