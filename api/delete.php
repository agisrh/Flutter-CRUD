<?php
header('Content-Type: application/json');
include_once('connection.php');

// Jika semua data npm yg dikirim ada, maka proses request user
if (isset($_POST['npm']))
{
    $npm     = htmlentities($_POST['npm']);
    $cekdata = mysqli_query($koneksi,"SELECT * FROM mahasiswa WHERE npm = '$npm'");
    $rows    = mysqli_num_rows($cekdata);
    $query   = "DELETE FROM mahasiswa WHERE npm = '$npm'";
    $delete  = mysqli_query($koneksi,$query);
    $response = array();

    // jika data ada di dalam database maka lakukan proses berikutnya
    if($rows > 0)
    {
      // jika data berhasil di hapus
      if ($delete) {
        $response['status']  = 200;
        $response['message'] = "Data berhasil dihapus !";

      // jika gagal dihapus
      }else{
        $response['status']  = 409;
        $response['message'] = "Data gagal dihapus !";
      }

    // jika data tidak ditemukan
    }else{
        $response['status']  = 409;
        $response['message'] = "Data tidak ditemukan !";
    }
// Jika tidak ada data yg dikrim beri pesan
}else{
  $response['status'] = 400;
  $response['message'] = "Permintaan tidak sesuai !";
}

echo json_encode($response);
?>