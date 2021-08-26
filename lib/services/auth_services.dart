part of 'services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth =
      auth.FirebaseAuth.instance; // buat instancenya dulu

  //Sign up
  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, String occupation, String dob) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user
          .convertToUser(name: name, occupation: occupation, dateOfBirth: dob);

      await UserServices.updateUser(user);
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<auth.User> get userStream {
    return _auth.authStateChanges();
  }
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
