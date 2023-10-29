import 'package:codered/fire_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Red With"),
      ),
      body: Column(children: [
        ElevatedButton(onPressed: (){
          FirebaseService.signInwithGoogle(context);
        }, child:Text("Login With Google")),
      ],),
    );
  }
}