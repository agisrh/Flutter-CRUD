class MahasiswaModel {
  String nim;
  String nama;
  String prodi;
  String fakultas;

  MahasiswaModel({this.nim, this.nama, this.prodi, this.fakultas});

  MahasiswaModel.fromJson(Map<String, dynamic> json) {
    nim = json['nim'].toString();
    nama = json['nama'].toString();
    prodi = json['prodi'].toString();
    fakultas = json['fakultas'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['nama'] = this.nama;
    data['prodi'] = this.prodi;
    data['fakultas'] = this.fakultas;
    return data;
  }
}
