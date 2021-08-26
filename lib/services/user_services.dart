part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'dateOfBirth': user.dateOfBirth,
      'occupation': user.occupation,
      'profilePicture': user.profilePicture ?? "",
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(
      id,
      snapshot.data()['email'],
      balance: snapshot.data()['balance'],
      name: snapshot.data()['name'],
      dateOfBirth: snapshot.data()['dateOfBirth'],
      occupation: snapshot.data()['occupation'],
      profilePicture: snapshot.data()['profilePicture'],
    );
  }

  static Future<void> updateUserInfo(String email, String password, String uid,
      {String dateOfBirth, String occupation, String username}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': username,
        'dateOfBirth': dateOfBirth,
        'occupation': occupation,
        'email': email,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> updateImage(String imageUrl, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'profilePicture': imageUrl});
    } catch (e) {
      print(e.toString());
    }
  }
  /* Static Future<User> getUser(String email) async{

  } */
}
