import 'package:criminal_catcher/injection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Authentication/login_screen.dart'; // Ensure the correct import path
import 'firebase_options.dart'; // Ensure this file exists
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initInjection();
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
  shadowColor: Colors.green,
  primarySwatch: Colors.grey,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
    accentColor: Colors.indigo,
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
    bodySmall: TextStyle(fontSize: 12, color: Colors.black87),
    headlineLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
  ),
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
