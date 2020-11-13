import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_flutter/constants.dart';
import 'signup_screen.dart';

final _firestore = FirebaseFirestore.instance;

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UsersStream(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                child: Icon(Icons.add),
                backgroundColor: darkPurple,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: double.infinity),
          ],
        ),
      ],
    );
  }
}

class UsersStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data.docs[index];
              Map<String, dynamic> user = document.data();
              return UserCard(
                name: user['name'],
                email: user['email'],
                role: user['role'],
              );
            },
          ),
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  UserCard({
    @required this.name,
    @required this.email,
    @required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 80,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 50,
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(email),
                    Text(role),
                  ],
                )
              ],
            ),
          ),
          elevation: 5.0,
          color: blueGrey,
        ),
      ),
    );
  }
}
