import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mahasiswa/src/ui/screens/list_mahasiswa.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Mahasiswa(),
          ),
          (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Image.asset(
                'assets/images/sttdb.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
