part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  User convertToUser(
          {String name = "No Name",
          int balance = 50000,
          String occupation = "Occupation",
          String dateOfBirth = "yyyy-mm-dd"}) =>
      User(this.uid, this.email,
          name: name,
          dateOfBirth: dateOfBirth,
          occupation: occupation,
          balance: balance);

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
