import 'package:codered/Login.dart';
import 'package:codered/firebase_options.dart';
import 'package:codered/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
