import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NewsApp extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with google
  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await _auth.signInWithCredential(authCredential);
    }
    notifyListeners();
  }

  // sign out from google
  void signOut() {
    _auth.signOut();
    notifyListeners();
  }
}
