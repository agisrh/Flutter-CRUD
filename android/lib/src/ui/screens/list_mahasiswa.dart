import 'package:flutter/material.dart';
import 'package:mahasiswa/src/core/providers/mahasiswa_providers.dart';
import 'package:mahasiswa/src/ui/screens/add_mahasiswa.dart';
import 'package:mahasiswa/src/ui/screens/edit_mahasiswa.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class Mahasiswa extends StatefulWidget {
  @override
  _MahasiswaState createState() => _MahasiswaState();
}

class _MahasiswaState extends State<Mahasiswa> {
  final snackbarKey = GlobalKey<ScaffoldState>();

  // Fingsi inisial nama
  String getInitials(String words) {
    if (words.isNotEmpty) {
      return words.trim().split(' ').map((l) => l[0]).take(2).join();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ClipRRect(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              child: Text(
                "Kelompok 1",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddMahasiswa(),
            ),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<MahasiswaProvider>(context, listen: false)
            .getMahasiswa(),
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.deepPurple,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    height: 150.0,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset("assets/images/sttdb.png"),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "STT Duta Bangsa",
                                  style: TextStyle(
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Teknik Informatika",
                                  style: TextStyle(
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: Provider.of<MahasiswaProvider>(context, listen: false)
                      .getMahasiswa(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: null,
                          strokeWidth: 2.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepPurple),
                        ),
                      );
                    }
                    return Consumer<MahasiswaProvider>(
                      builder: (context, data, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.dataMahasiswa.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MahasiswaEdit(
                                      nim: data.dataMahasiswa[i].nim,
                                    ),
                                  ),
                                );
                              },
                              child: Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Konfirmasi'),
                                          content: Text(
                                              'Apakah anda yakin ingin menghapus ' +
                                                  data.dataMahasiswa[i].nama +
                                                  ' ?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text('Batalkan'),
                                            ),
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text('Hapus'),
                                            )
                                          ],
                                        );
                                      });
                                  return res;
                                },
                                onDismissed: (value) {
                                  Provider.of<MahasiswaProvider>(context,
                                          listen: false)
                                      .deleteMahasiswa(
                                          data.dataMahasiswa[i].nim)
                                      .then(
                                    (res) {
                                      if (res) {
                                        setState(() {});
                                        var snackbar = SnackBar(
                                          content:
                                              Text('Data berhasil dihapus !'),
                                        );
                                        snackbarKey.currentState
                                            .showSnackBar(snackbar);
                                      } else {
                                        var snackbar = SnackBar(
                                          content:
                                              Text('Ops, data gagal dihapus !'),
                                        );
                                        snackbarKey.currentState
                                            .showSnackBar(snackbar);
                                      }
                                    },
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.primaries[
                                                Random().nextInt(
                                                    Colors.primaries.length)]
                                            .withOpacity(1.0),
                                        child: Text(
                                          getInitials(
                                              data.dataMahasiswa[i].nama),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        data.dataMahasiswa[i].nama,
                                      ),
                                      subtitle: Text(data.dataMahasiswa[i].nim +
                                          ' - ' +
                                          data.dataMahasiswa[i].prodi),
                                      trailing:
                                          Icon(Icons.keyboard_arrow_right),
                                    ),
                                    new Divider(
                                      height: 1.0,
                                      indent: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
