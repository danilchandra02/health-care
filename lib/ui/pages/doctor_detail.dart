part of 'pages.dart';

class DoctorDetail extends StatelessWidget {
  final Doctor doctor;
  final cur = new NumberFormat("#,###", "en_US");

  DoctorDetail(this.doctor);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 1.0),
              color: Colors.white,
            ),
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(doctor.profPic),
                        radius: 50,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              doctor.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'NunitoBold',
                              ),
                            ),
                            Text(
                              doctor.expert,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Text(
                              "Rp ${cur.format(doctor.price)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NunitoSemiBold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width / 2.7,
                        color: secondaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: mainColor,
                            ),
                            Text(
                              "99.0 %",
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 16,
                                fontFamily: 'NunitoSemiBold',
                              ),
                            ),
                            Text(
                              "Likes",
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width / 2.7,
                        color: mainColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.work,
                              color: secondaryColor,
                            ),
                            Text(
                              "3 Years",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16,
                                fontFamily: 'NunitoSemiBold',
                              ),
                            ),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.assignment_ind),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Graduate from",
                                style: TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Universitas Andalas, 2016",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.home),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Places of Practice",
                                style: TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  "Puskesmas Padang Pasir Padang, Sumatra Utara",
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.flag),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "STR NUMBER",
                                style: TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "7321100119201822",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 45.0,
                        buttonColor: mainColor,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            context.bloc<PageBloc>().add(GoToLiveChat(doctor));
                          },
                          child: Text(
                            "Chat",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
