<?php
header('Content-Type: application/json');
include_once('connection.php');
  $query  = "SELECT * FROM mahasiswa";
  $result = mysqli_query($koneksi,$query);
  $array_data = array();
  $response   = array();
  
  // jika query berhasil
  if($query){
    $response['status'] = 200;
    $response['message'] = "Data mahasiswa";
    while($baris = mysqli_fetch_assoc($result))
    {
      $array_data[]=$baris;
      
    }
    $response['data'] = $array_data;

  // jika gagal
  }else{
    $response['status'] = 409;
    $response['message'] = "Terjadi kesalahan !";
  }
  
  echo json_encode($response, JSON_PRETTY_PRINT);
?>