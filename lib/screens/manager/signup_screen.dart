import '../../constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import '../../data/roles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../services/auth.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name;
  String email;
  String password;
  String confirmPassword;
  String selectedRole;
  bool showSpinner = false;

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String role in rolesList) {
      pickerItems.add(Text(role));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedRole = rolesList[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String role in rolesList) {
      var newItem = DropdownMenuItem(
        child: Text(role),
        value: role,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      hint: Text('Select a role'),
      value: selectedRole,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
      },
    );
  }

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
                    'assets/vectors/signup.svg',
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
              ),
              SizedBox(
                height: 8.0,
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
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Confirm password'),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Platform.isIOS ? iOSPicker() : androidDropdown(),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Color(0xFF7579E7),
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  if (password == confirmPassword) {
                    dynamic result = await AuthServices.signUp(
                        email.trim(), password.trim(), selectedRole, name);
                    if (result != null) {
                      setState(() {
                        showSpinner = false;
                      });
                      Alert(
                        context: context,
                        title: "Sign Up Successful",
                        desc: "result",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Okay",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      );
                    }
                  } else {
                    setState(() {
                      showSpinner = false;
                    });
                    Alert(
                      context: context,
                      title: "Password Doesn't Match",
                      desc: "Please check your password again",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Okay",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
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
