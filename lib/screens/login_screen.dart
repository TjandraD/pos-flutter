import 'package:flutter/material.dart';
import 'package:pos_flutter/screens/admin/home_admin.dart';
import 'package:pos_flutter/screens/manager/home_manager.dart';
import '../widgets/rounded_button.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 200.0,
                  child: SvgPicture.asset(
                    'assets/vectors/login.svg',
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: blueGrey,
                title: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  dynamic result =
                      await AuthServices.logIn(email.trim(), password.trim());

                  setState(() {
                    showSpinner = false;
                  });

                  if (result != null) {
                    String role = await AuthServices.validateUserRole(result);
                    if (role == 'Manager') {
                      Navigator.pushNamed(context, HomeManager.id);
                    }
                    if (role == 'Admin') {
                      Navigator.pushNamed(context, HomeAdmin.id);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
