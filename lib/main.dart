import 'package:adv_flutter_app/Screens/homepage.dart';
import 'package:adv_flutter_app/Screens/loginPage.dart';
import 'package:adv_flutter_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'home_Page': (context) => HomePage(),
        '/': (context) => LoginPage(),
      },
    ),
  );
}
