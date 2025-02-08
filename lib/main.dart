import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_auto/pages/dashboard/dashboard_page.dart';
import 'package:proyecto_auto/pages/graphs/home_graphs.dart';
import 'package:proyecto_auto/pages/home_page.dart';
import 'package:proyecto_auto/pages/login_page.dart';
import 'package:proyecto_auto/pages/nc.dart';
import 'package:proyecto_auto/pages/register_page.dart';
import 'package:proyecto_auto/pages/dashboard/dashComb_page.dart';
import 'package:proyecto_auto/pages/dashboard/dashOx_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
