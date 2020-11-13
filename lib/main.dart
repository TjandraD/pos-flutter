import 'package:flutter/material.dart';
import 'package:pos_flutter/screens/admin/home_admin.dart';
import 'package:pos_flutter/screens/login_screen.dart';
import 'package:pos_flutter/screens/manager/home_manager.dart';
import 'package:pos_flutter/screens/manager/signup_screen.dart';
import 'package:pos_flutter/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomeManager.id: (context) => HomeManager(),
        HomeAdmin.id: (context) => HomeAdmin(),
      },
    );
  }
}
