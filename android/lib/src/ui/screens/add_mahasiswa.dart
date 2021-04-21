import 'package:flutter/material.dart';
import 'package:mahasiswa/src/core/providers/mahasiswa_providers.dart';
import 'package:mahasiswa/src/ui/screens/list_mahasiswa.dart';
import 'package:provider/provider.dart';

class AddMahasiswa extends StatefulWidget {
  @override
  _AddMahasiswaState createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  final TextEditingController _nim = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _prodi = TextEditingController();
  final TextEditingController _fakultas = TextEditingController();
  bool _isLoading = false;

  final snackbarKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  void submit(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MahasiswaProvider>(context, listen: false)
          .storeMahasiswa(_nim.text, _nama.text, _prodi.text, _fakultas.text)
          .then(
        (res) {
          if (res) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Mahasiswa()),
                (route) => false);
          } else {
            var snackbar = SnackBar(
              content: Text('Ops, Terjadi kesalahan !'),
            );
            snackbarKey.currentState.showSnackBar(snackbar);
            setState(() {
              _isLoading = false;
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text(
          'Tambah Mahasiswa'.toUpperCase(),
          style: TextStyle(fontFamily: 'helvetica_neue_light', fontSize: 15.0),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _nim,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NIM',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'NIM tidak boleh kosong !';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _nama,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Lengkap',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nama tidak boleh kosong !';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _fakultas,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fakultas',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Fakultas tidak boleh kosong !';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _prodi,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prodi',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Prodi tidak boleh kosong !';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: _isLoading
            ? CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Icon(
                Icons.save,
                color: Colors.white,
              ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            submit(context);
          }
        },
      ),
    );
  }
}
