part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String today = DateFormat('EEEE, dd MMM').format(DateTime.now());
  String email = auth.FirebaseAuth.instance.currentUser.email;
  TextEditingController textUsername = TextEditingController();
  String profilePic;
  //bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  Future<void> _getInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                textUsername.text = 'Hi, ${doc["name"]}';
                profilePic = doc['profilePicture'];
                //isLoading = false;
                //print('Ok Reload');
              })
            });

    if (profilePic == '') {
      profilePic =
          'https://bbs.calderdale.sch.uk/wp-content/uploads/2014/03/blank-person.png';
    }
  }

  //String userId = auth.FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getInfo,
      child: FutureBuilder(
          future: _getInfo(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Future hasn't finished yet, return a placeholder
              return SpinKitFadingCircle(
                color: mainColor,
              );
            }
            return ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        //AuthServices.signOut();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                return showDialog(
                                  context: context,
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: PhotoView(
                                            imageProvider:
                                                NetworkImage(profilePic),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10, 30, 10, 10),
                                          height: 30,
                                          color: Colors.transparent,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.arrow_back,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(profilePic),
                                radius: 30,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.account_balance_wallet),
                                  SizedBox(width: 5),
                                  Text(
                                    'Rp 50,000',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NunitoSemiBold',
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$today",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'NunitoLight',
                            ),
                          ),
                          /* BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) => (userState is UserLoaded)
                        
                                padding: EdgeInsets.only(right: 25),
                                child: Text(
                                  // "Hi, ${userState.user.name}",
                                  "Hi",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'NunitoExtraBold',
                                  ),
                                ),
                              )
                            : SpinKitFadingCircle(
                                color: mainColor,
                              ),
                      ), */
                          TextField(
                            // "Hi, ${userState.user.name}",
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines: 5,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            enabled: false,
                            controller: textUsername,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'NunitoExtraBold',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "On Going",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NunitoBold',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 1.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.date_range),
                                      SizedBox(width: 10),
                                      Text(
                                        "Meet Dr. Chikansono",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "2.30 PM",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 16, left: 16),
                      width: 140,
                      child: Text(
                        "Other Services",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: 100,
                                    height: 130,
                                    child: Column(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              'assets/img/medicine.png'),
                                          width: 46,
                                          height: 46,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 55,
                                          width: 65,
                                          child: Text(
                                            "Health Store",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'NunitoSemiBold',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: 100,
                                    height: 130,
                                    child: Column(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              'assets/img/doctor.png'),
                                          width: 46,
                                          height: 46,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 55,
                                          width: 65,
                                          child: Text(
                                            "Health Doctor",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'NunitoSemiBold',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: 100,
                                    height: 130,
                                    child: Column(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              'assets/img/hospital.png'),
                                          width: 46,
                                          height: 46,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 55,
                                          width: 65,
                                          child: Text(
                                            "Health Hospital",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'NunitoSemiBold',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "Top Rated Doctors",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            height: 275,
                            child: Row(
                              children: [
                                Expanded(
                                  //child: (userId == 'danil123@passwordsama.com')

                                  child: email == 'danil123@passwordsama.com'
                                      ? user(context)
                                      : doctor(context),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Good News",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: "#7D8797".toColors(),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Is it safe to stay at home during corono virus ?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image(
                                  image: AssetImage('assets/img/news1.jpg'),
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: "#7D8797".toColors(),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Is it true that Vitamin C can help the body's immune system be stronger against corona?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image(
                                  image: AssetImage('assets/img/news2.jpg'),
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: "#7D8797".toColors(),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Which hospital can treat Corona patients?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image(
                                  image: AssetImage('assets/img/news3.jpg'),
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 75),
                  ],
                )
              ],
            );
          }),
    );
  }

  Widget user(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: SpinKitFadingCircle(
            color: mainColor,
          ));
        }
        return ListView.builder(
          itemCount: snapshot.data.size,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            QueryDocumentSnapshot temp = snapshot.data.docs[index];
            User user = User("", temp.get('email'));
            return Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.all(10),
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0),
              ),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/img/doc-1.jpg'),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    snapshot.data.docs[index].get('name'),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                    ),
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
                        context.bloc<PageBloc>().add(GoToLiveDoctor(user));
                      },
                      child: Text(
                        "CHAT NOW",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget doctor(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('doctors').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: SpinKitFadingCircle(
            color: mainColor,
          ));
        }
        return ListView.builder(
          itemCount: snapshot.data.size,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            QueryDocumentSnapshot temp = snapshot.data.docs[index];
            final cur = new NumberFormat("#,###", "en_US");
            Doctor doctor = Doctor(
              email: temp.get('email'),
              name: temp.get('name'),
              field: temp.get('field'),
              expert: temp.get('expert'),
              id: temp.get('id'),
              price: temp.get('price'),
              profPic: temp.get('profPicture'),
            );
            if (index == 0) {
              return Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.all(10),
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(width: 1.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data.docs[index].get('profPicture')),
                          radius: 40,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          snapshot.data.docs[index].get('name'),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          snapshot.data.docs[index].get('expert'),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NunitoLight',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/img/ic-star.png'),
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              Image(
                                image: AssetImage('assets/img/ic-star.png'),
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              Image(
                                image: AssetImage('assets/img/ic-star.png'),
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              Image(
                                image: AssetImage('assets/img/ic-star.png'),
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              Image(
                                image: AssetImage('assets/img/ic-star.png'),
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                color: Colors.grey,
                                width: 75,
                                child: Text(
                                  snapshot.data.docs[index].get('field'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                    color: "#FFFFFF".toColors(),
                                  ),
                                ),
                              ),
                              Text(
                                "Rp ${cur.format(snapshot.data.docs[index].get('price'))}",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
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
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToDoctorDetail(doctor));
                            },
                            child: Text(
                              "BOOK NOW",
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
              );
            } else {
              return Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.all(10),
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1.0),
                ),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data.docs[index].get('profPicture')),
                      radius: 40,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      snapshot.data.docs[index].get('name'),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      snapshot.data.docs[index].get('expert'),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NunitoLight',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/img/ic-star.png'),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('assets/img/ic-star.png'),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('assets/img/ic-star.png'),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('assets/img/ic-star.png'),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('assets/img/ic-star.png'),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            color: Colors.grey,
                            width: 75,
                            child: Text(
                              snapshot.data.docs[index].get('field'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: "#FFFFFF".toColors(),
                              ),
                            ),
                          ),
                          Text(
                            "Rp ${cur.format(snapshot.data.docs[index].get('price'))}",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
                          context
                              .bloc<PageBloc>()
                              .add(GoToDoctorDetail(doctor));
                        },
                        child: Text(
                          "BOOK NOW",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Nunito'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
