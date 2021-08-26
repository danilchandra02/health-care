part of 'services.dart';

class ChatServices {
  static Future<void> createChatRoom(String sender, String receiver,
      String text, String time, String date) async {
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc("$sender")
          .collection("$receiver")
          .doc()
          .set({
        'sender': sender,
        'receiver': receiver,
        'text': text,
        'time': time
      });
      /*  await FirebaseFirestore.instance
          .collection("messages")
          .doc("$sender")
          .set({
        'docEmail': receiver,
        'lastChat': text,
        'time': time,
      }); */
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteChat(
      String chatId, String receiverId, String senderId) async {
    try {
      print("$chatId,$receiverId,$senderId");
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(senderId)
          .collection(receiverId)
          .doc(chatId)
          .delete()
          .then((value) => print("Chat Deleted"));
    } catch (e) {
      print(e.toString());
    }
  }
}

class ChatServices2 {
  static Future<void> createChatRoom(String sender, String receiver,
      String text, String time, String date) async {
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc("$receiver")
          .collection("$sender")
          .doc()
          .set({
        'sender': sender,
        'receiver': receiver,
        'text': text,
        'time': time
      });
      /*  await FirebaseFirestore.instance
          .collection("messages")
          .doc("$sender")
          .set({
        'docEmail': receiver,
        'lastChat': text,
        'time': time,
      }); */
    } catch (e) {
      print(e.toString());
    }
  }
}
