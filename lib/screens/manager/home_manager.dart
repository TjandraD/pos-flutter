import 'package:flutter/material.dart';
import 'package:pos_flutter/constants.dart';
import 'package:pos_flutter/screens/manager/user_list.dart';
import 'dart:async';
import '../../widgets/bottom_navigation.dart';
import '../../services/auth.dart';

class HomeManager extends StatefulWidget {
  static String id = 'home_manager';

  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
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
          UserList(),
          Center(
            child: Text('Items'),
          ),
          Center(
            child: Text('Transactions'),
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
                    icon: Icon(Icons.person), title: Text('User')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.list_alt_rounded), title: Text('Items')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.local_atm), title: Text('Transactions')),
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
