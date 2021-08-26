part of 'pages.dart';

class LiveChat extends StatefulWidget {
  final Doctor doctor;
  const LiveChat(Key key, this.doctor) : super(key: key);
  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  TextEditingController textController = TextEditingController();
  String today = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String now = DateTime.now().toString();
  String userId = auth.FirebaseAuth.instance.currentUser.email;
  ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFB2C7D9),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToMainPage());
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    widget.doctor.name,
                                    style: TextStyle(
                                        fontFamily: 'NunitoSemiBold',
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    widget.doctor.expert,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        color: Colors.white,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.doctor.profPic),
                                radius: 25,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Expanded(
                      child: resultChat(context),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontSize: 16),
                        keyboardType: TextInputType.multiline,
                        minLines: 1, //Normal textInputField will be displayed
                        maxLines:
                            5, // when user presses enter it will adapt to it
                        decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Color(0xFFEDEEF0),
                          hintText: 'Type a Message.....',
                          hintStyle: TextStyle(
                              fontFamily: 'NunitoLight', fontSize: 16),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    FloatingActionButton(
                      backgroundColor: mainColor,
                      elevation: 0,
                      child: SizedBox(
                        height: 26,
                        width: 26,
                        child: Icon(
                          Icons.send,
                          color: Colors.white.withOpacity(0.74),
                        ),
                      ),
                      onPressed: () {
                        now = DateTime.now().toString();
                        if (textController.text == '') {
                          return null;
                        } else {
                          scrollToBottom();
                          ChatServices.createChatRoom(
                              userId,
                              widget.doctor.email,
                              textController.text,
                              now,
                              today);
                          textController.clear();
                        }
                      },
                    ),
                  ],
                ),
                /* child: Card(
                  child: ListTile(
                    title: TextField(),
                    trailing: IconButton(icon: Icon(Icons.send), onPressed: null),
                  ),
                ), */
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget resultChat(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(userId)
          .collection(widget.doctor.email)
          .orderBy('time')
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitFadingCircle(
            color: mainColor,
          );
        } else {
          var doc = snapshot.data.docs;
          return ListView.builder(
            controller: _scrollController,
            //reverse: true,
            shrinkWrap: true,
            itemCount: doc.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, int index) {
              //QueryDocumentSnapshot temp = snapshot.data.docs[index];
              if (doc[index].get("sender") == userId) {
                return myMessage(doc[index].get("text"), doc[index].get("time"),
                    widget.doctor.email, doc[index].id);
              } else {
                return urMessage(
                    doc[index].get("text"), doc[index].get("time"));
              }
            },
          );
        }
      },
    );
  }

  Widget myMessage(String chat, String time, String receiverId, String chatId) {
    String hour = time.split(" ")[1].split(":")[0];
    String min = time.split(" ")[1].split(":")[1];
    (int.parse(hour) >= 12)
        ? time = "${int.parse(hour) - 12}:$min PM"
        : time = "$hour:$min AM";
    return GestureDetector(
      onLongPress: () {
        print(receiverId);
        return showDialog(
          barrierDismissible: false,
          context: context,
          child: AlertDialog(
            title: Text('Confirmation'),
            content: Text('Do you want to delete this message ?'),
            actions: [
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: mainColor,
                child: Text("Yes"),
                onPressed: () {
                  ChatServices.deleteChat(chatId, receiverId, userId);
                  Navigator.of(context).pop();
                  Flushbar(
                    duration: Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Color(0xFFFF5C83),
                    message: "Chat has been deleted",
                  )..show(context);
                },
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(100, 10, 16, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  chat,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: TextStyle(
                    fontFamily: 'NunitoLight',
                    fontSize: 14,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget urMessage(String chat, String time) {
    String hour = time.split(" ")[1].split(":")[0];
    String min = time.split(" ")[1].split(":")[1];
    (int.parse(hour) >= 12)
        ? time = "${int.parse(hour) - 12}:$min PM"
        : time = "$hour:$min AM";
    return Container(
      margin: EdgeInsets.fromLTRB(16, 10, 120, 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.doctor.profPic),
              radius: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        chat,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: TextStyle(
                          fontFamily: 'NunitoLight',
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
