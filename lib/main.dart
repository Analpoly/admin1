// import 'package:admin1/homepage.dart';
import 'package:admin1/contextdate.dart';
import 'package:admin1/homepage.dart';
import 'package:admin1/login.dart';
// import 'package:admin1/login.dart';
import 'package:admin1/shopping_app/lib/firebase_options.dart';]
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home:  Adminlogin (),
    debugShowCheckedModeBanner: false,
  ));
}