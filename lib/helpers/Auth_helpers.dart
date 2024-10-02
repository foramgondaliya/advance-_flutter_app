import 'package:firebase_auth/firebase_auth.dart';

class AuthHelpers {
  AuthHelpers._();

  static final AuthHelpers authHelpers = AuthHelpers._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> SignUpWithEmailAndPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res["user"] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          print("This email is already exist");
          break;

        default:
          print("${e.credential}");
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> SignInWithEmailAndPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res["user"] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-password":
          print("Password is Invalid");
          break;

        default:
          print("${e.credential}");
      }
    }
    return res;
  }

  SignOut() {
    firebaseAuth.signOut();
  }
}
