import 'package:flutter/material.dart';
import 'package:pos_flutter/constants.dart';
import 'dart:async';
import '../../widgets/bottom_navigation.dart';
import '../../services/auth.dart';

class HomeAdmin extends StatefulWidget {
  static String id = 'home_admin';

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await AuthServices.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Home'),
        backgroundColor: darkPurple,
      ),
      body: PageView(
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          Center(
            child: Text('Items'),
          ),
          Center(
            child: Text('Brands'),
          ),
          Center(
            child: Text('Distributors'),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              activeColor: darkPurple,
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.list_alt_rounded), title: Text('Items')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.list), title: Text('Brands')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title: Text('Distris')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}
