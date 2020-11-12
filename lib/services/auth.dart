import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  static String error;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<String> signUp(
      String email, String password, String role, String name) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      await _auth.currentUser.updateProfile(displayName: name);
      _firestore.collection('users').doc(user.uid).set({
        'role': role,
      });
      return user.uid;
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user.uid;
    } catch (error) {
      print(error);
      return error.message;
    }
  }
}
