import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Authentication/login_screen.dart'; // Ensure the correct import path
import 'firebase_options.dart'; // Ensure this file exists
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  runApp(const MyApp());
}

ThemeData appTheme = ThemeData(
  primaryColor: Colors.black,
  highlightColor: Colors.white,
  shadowColor: Colors.green
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Pak',
      theme: appTheme,
      home: LoginScreen(),
    );
  }
}
