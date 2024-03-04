import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign In
  signInWithGoogle() async {
    // Begin an interactive signin
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details form request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create  a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
