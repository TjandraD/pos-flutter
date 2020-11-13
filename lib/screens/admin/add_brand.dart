import '../../constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import '../../services/auth.dart';

class AddBrand extends StatefulWidget {
  static String id = 'add_brand';

  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  String brandName;
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
                  brandName = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Brand Name'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: darkPurple,
                title: 'Add Brand',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  dynamic result = await AuthServices.addBrand(brandName);
                  if (result != null) {
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.pop(context);
                  }

                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
