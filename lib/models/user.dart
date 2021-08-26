part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String dateOfBirth;
  final String occupation;
  final int balance;

  User(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.dateOfBirth,
      this.occupation,
      this.balance});

  @override
  String toString() {
    return "[$id] - $name , $email";
  }

  @override
  List<Object> get props =>
      [id, email, name, profilePicture, dateOfBirth, occupation, balance];
}
