import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/vectors/welcome.svg',
            ),
            SizedBox(
              height: 25.0,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, '');
              },
              color: Color(0xFF9AB3F5),
              title: 'Log In',
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, '');
              },
              color: Color(0xFF7579E7),
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
