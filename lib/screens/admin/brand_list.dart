import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_flutter/constants.dart';
import 'package:pos_flutter/screens/admin/add_brand.dart';

final _firestore = FirebaseFirestore.instance;

class BrandList extends StatefulWidget {
  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BrandStream(),
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
                  Navigator.pushNamed(context, AddBrand.id);
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

class BrandStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('brands').snapshots(),
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
              Map<String, dynamic> brand = document.data();
              return BrandCard(
                name: brand['brand'],
              );
            },
          ),
        );
      },
    );
  }
}

class BrandCard extends StatelessWidget {
  final String name;

  BrandCard({
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 70,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          elevation: 5.0,
          color: blueGrey,
        ),
      ),
    );
  }
}
