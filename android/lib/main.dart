import 'package:flutter/material.dart';
import 'package:mahasiswa/src/core/providers/mahasiswa_providers.dart';
import 'package:mahasiswa/src/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MahasiswaProvider(),
        )
      ],
      child: MaterialApp(
        theme: new ThemeData(primaryColor: Colors.deepPurple),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
