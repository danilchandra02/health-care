part of 'pages.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String userId = auth.FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(16),
            child: Text(
              'Messages',
              style: TextStyle(fontFamily: 'NunitoExtraBold', fontSize: 24),
            ),
          ),
          Expanded(
            child: allMsg(context),
          ),
        ],
      ),
    );
  }

  Widget allMsg(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('chats').get(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: SpinKitFadingCircle(
              color: mainColor,
            ));
          } else {
            return ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.4, color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/img/jessica.png'),
                              radius: 30,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontFamily: 'NunitoBold', fontSize: 18),
                                  ),
                                  Text(
                                    'Halo Dokter..',
                                    style: TextStyle(
                                        fontFamily: 'Nunito', fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
