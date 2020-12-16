import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:topper/features.dart';
import 'package:topper/home.dart';
import 'package:topper/library.dart';
import 'package:topper/profile.dart';
import 'package:topper/refer.dart';
import 'package:topper/register.dart';
import 'package:topper/reset_password.dart';
import 'package:topper/share.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget nextPage() {
    var user = FirebaseAuth.instance.currentUser; 
    return user != null ? Library() : Home();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff0e427b),
        fontFamily: 'comic',
        textTheme: TextTheme(
          subtitle: TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),
          title: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Color(0xff0e427b),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: nextPage(),
    );
  }
}
