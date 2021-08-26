part of 'models.dart';

class Chat extends Equatable {
  final String sender;
  final String receiver;
  final String text;
  final String time;

  Chat({this.sender, this.receiver, this.text, this.time});

  @override
  List<Object> get props => [sender, receiver, text, time];
}
