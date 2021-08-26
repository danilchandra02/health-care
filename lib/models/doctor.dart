part of 'models.dart';

class Doctor extends Equatable {
  final String email;
  final String expert;
  final String field;
  final String id;
  final String name;
  final int price;
  final String profPic;

  Doctor(
      {this.id,
      this.email,
      this.name,
      this.expert,
      this.field,
      this.price,
      this.profPic});

  @override
  List<Object> get props => [id, email, name, expert, field, price, profPic];
}
