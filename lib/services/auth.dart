// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class OAuth {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign in with google
  Future<void> googleSignIn() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    // final GoogleSignInAccount? googleSignInAccount =
    //     await googleSignIn.signIn();
    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;
    //   final AuthCredential authCredential = GoogleAuthProvider.credential(
    //       idToken: googleSignInAuthentication.idToken,
    //       accessToken: googleSignInAuthentication.accessToken);

    // await _firebaseAuth.signInWithCredential(authCredential);
    // }
  }

  // sign out from google
  void signOut() {
    // _firebaseAuth.signOut();
  }
}
