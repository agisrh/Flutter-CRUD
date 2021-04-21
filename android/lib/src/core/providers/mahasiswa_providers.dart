import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mahasiswa/src/core/models/mahasiswa_model.dart';

class MahasiswaProvider extends ChangeNotifier {
  List<MahasiswaModel> _data = [];
  List<MahasiswaModel> get dataMahasiswa => _data;

  // Daftar Mahasiswa
  Future<List<MahasiswaModel>> getMahasiswa() async {
    final url = 'http://api.kurier.id/view.php';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<MahasiswaModel>((json) => MahasiswaModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  // Tambah Data
  Future<bool> storeMahasiswa(
      String nim, String nama, String prodi, String fakultas) async {
    final url = 'http://api.kurier.id/create.php';
    final response = await http.post(url, body: {
      'nim': nim,
      'nama': nama,
      'prodi': prodi,
      'fakultas': fakultas,
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // Ambil data berdasarkan NIM
  Future<MahasiswaModel> findMahasiswa(String nim) async {
    return _data.firstWhere((i) => i.nim == nim);
  }

  // Update Mahasiswa
  Future<bool> updateMahasiswa(
      String nim, String nama, String prodi, String fakultas) async {
    final url = 'http://api.kurier.id/update.php';
    final response = await http.post(url,
        body: {'nim': nim, 'nama': nama, 'prodi': prodi, 'fakultas': fakultas});

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // Hapus Mahasiswa
  Future<bool> deleteMahasiswa(String nim) async {
    final url = 'http://api.kurier.id/delete.php';
    final response = await http.post(url, body: {'nim': nim});

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }
}
