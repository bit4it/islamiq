import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamiq/screens/dua.dart';
import 'package:islamiq/screens/dua_details.dart';
import 'package:islamiq/screens/dualist.dart';
import 'package:islamiq/screens/home.dart';
import 'package:islamiq/screens/qibla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // 👈 set your color
      statusBarIconBrightness: Brightness.light, // 👈 icons: white
      statusBarBrightness: Brightness.dark, // 👈 for iOS
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aftab App',
      theme: ThemeData(
        fontFamily: "Kufam",
      ),
      home: HomeScreen(),
      routes: {
        '/qibla': (context) => const QiblaCompassScreen(),
        '/dua': (context) =>  DuaScreen(),
        '/dua/list': (context) =>  DuaListScreen(),
        '/dua/details': (context) =>  DuaDetailsScreen(),
      },
    );
  }
}
