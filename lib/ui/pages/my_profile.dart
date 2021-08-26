part of 'pages.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController textUsername = TextEditingController();
  TextEditingController currentPass = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textOccupation = TextEditingController();
  TextEditingController textDate = TextEditingController();
  TextEditingController textNewPass = TextEditingController();
  TextEditingController textNewPass2 = TextEditingController();

  String email = auth.FirebaseAuth.instance.currentUser.email;
  String uid, nDOB, error;
  String profilePic, oldImage;
  File newImage;
  PickedFile _image;
  var resultUser;

  var result;
  bool _enabled = false;
  //bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  Future<void> _getInfo() async {
    uid = auth.FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                textUsername.text = doc["name"];
                textEmail.text = doc["email"];
                textOccupation.text = doc["occupation"];
                textDate.text = doc["dateOfBirth"];
                profilePic = doc['profilePicture'];
                print("oke");
              })
            });
    oldImage = profilePic;
    if (profilePic == '') {
      profilePic =
          'https://bbs.calderdale.sch.uk/wp-content/uploads/2014/03/blank-person.png';
    }

    if (textOccupation.text == '') {
      textOccupation.text = 'Unemployed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInfo(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future hasn't finished yet, return a placeholder
          return SpinKitFadingCircle(
            color: mainColor,
          );
        }
        return RefreshIndicator(
          onRefresh: _getInfo,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: newImage == null
                          ? NetworkImage(profilePic)
                          : FileImage(newImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'My Profile',
                            style: TextStyle(
                                fontFamily: 'NunitoBold',
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: _enabled ? 0 : 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_enabled == true) {
                                _image = await getImage();
                                newImage = File(_image.path);
                                setState(() {});
                              }
                            },
                            child: _enabled
                                ? AvatarGlow(
                                    glowColor: Colors.blue,
                                    endRadius: 80.0,
                                    duration: Duration(milliseconds: 2000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration:
                                        Duration(milliseconds: 50),
                                    child: Material(
                                      elevation: 20.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        backgroundImage: newImage == null
                                            ? NetworkImage(profilePic)
                                            : FileImage(newImage),
                                        radius: 50,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      return showDialog(
                                        context: context,
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Container(
                                                child: PhotoView(
                                                  imageProvider: newImage ==
                                                          null
                                                      ? NetworkImage(profilePic)
                                                      : FileImage(newImage),
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
                                      backgroundImage: newImage == null
                                          ? NetworkImage(profilePic)
                                          : FileImage(newImage),
                                      radius: 60,
                                    ),
                                  ),
                          ),
                          Container(
                            width: double.infinity - 30,
                            child: IntrinsicWidth(
                              child: TextField(
                                  textInputAction: TextInputAction.done,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.center,
                                  minLines:
                                      1, //Normal textInputField will be displayed
                                  maxLines: 5,
                                  maxLength: 25,
                                  enabled: _enabled,
                                  controller: textUsername,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontSize: 24,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20.0),
                                    prefix: _enabled
                                        ? Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          )
                                        : null,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 4.0),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _enabled
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(
                        width: double.infinity,
                        height: 120,
                        child: Image.asset('assets/img/bcode.png'),
                      ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(40),
                      1: FixedColumnWidth(120)
                    },
                    children: [
                      TableRow(
                        children: [
                          Container(
                            height: 40,
                            child: Align(
                              child: Icon(Icons.assignment_ind),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Text(
                            'Account ID',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 16),
                          ),
                          Text(
                            uid.substring(0, 12),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 16),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            height: 40,
                            child: Align(
                              child: Icon(Icons.email),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'E-Mail',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            child: TextField(
                              maxLines: null,
                              enabled: false,
                              controller: textEmail,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                              ),
                              decoration: _enabled
                                  ? InputDecoration(
                                      border: InputBorder.none,
                                    )
                                  : InputDecoration(
                                      border: InputBorder.none,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 40,
                            child: Align(
                              child: Icon(Icons.work),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Occupation',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  fontSize: 16),
                            ),
                          ),
                          TextField(
                            enabled: _enabled,
                            maxLines: null,
                            textInputAction: TextInputAction.done,
                            controller: textOccupation,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                            decoration: _enabled
                                ? InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                  )
                                : InputDecoration(
                                    border: InputBorder.none,
                                  ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            height: 40,
                            child: Align(
                              child: Icon(Icons.calendar_today),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontSize: 16),
                          ),
                          _enabled
                              ? Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                  child: DateTimePicker(
                                    dateMask: 'd MMM, yyyy',
                                    initialValue: '',
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    dateLabelText: textDate.text,
                                    onChanged: (val) => textDate.text = val,
                                  ),
                                )
                              : Text(
                                  textDate.text,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 16),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                _enabled
                    ? Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: textNewPass,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                            ),
                            hintText: 'New Password',
                            labelText: "Fill to change password",
                            labelStyle: TextStyle(color: mainColor),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: mainColor,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                _enabled
                    ? Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: textNewPass2,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                            ),
                            hintText: 'Password Confirmation',
                            labelText: "Re-confirm your password",
                            labelStyle: TextStyle(color: mainColor),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: mainColor,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15,
                ),
                ButtonTheme(
                  minWidth: 150.0,
                  height: 45.0,
                  buttonColor: mainColor,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      _enabled
                          ? setState(() {
                              if (!EmailValidator.validate(textEmail.text)) {
                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Wrong formatted email address",
                                )..show(context);
                                return;
                              }

                              if (textNewPass.text != '') {
                                //kalau password diganti cek panjang password
                                if (textNewPass.text.length <= 5) {
                                  Flushbar(
                                    duration: Duration(milliseconds: 1500),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message:
                                        "Password's lenght min 6 characters",
                                  )..show(context);
                                  return;
                                } else {
                                  if (textNewPass.text != textNewPass2.text) {
                                    Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message:
                                          "Missmatch password and confirmed password",
                                    )..show(context);
                                    return;
                                  }
                                  auth.FirebaseAuth.instance.currentUser
                                      .updatePassword(textNewPass.text)
                                      .then((value) =>
                                          print("Password has been Changed"));
                                }
                              }

                              /* if (textEmail.text != email) {
                                auth.FirebaseAuth.instance.currentUser
                                    .updateEmail(textEmail.text)
                                    .catchError((e) {
                                  if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                    return;
                                  }
                                });
                              } */

                              UserServices.updateUserInfo(
                                  textEmail.text, null, uid,
                                  dateOfBirth: textDate.text,
                                  occupation: textOccupation.text,
                                  username: textUsername.text);
                              if (newImage != null) {
                                if (oldImage == '') {
                                  uploadImage(newImage).then((imageUrl) =>
                                      UserServices.updateImage(imageUrl, uid));
                                } else {
                                  //print("ini : $oldImage");
                                  replaceImage(newImage, oldImage).then(
                                      (imageUrl) => UserServices.updateImage(
                                          imageUrl, uid));
                                }
                              }

                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.green,
                                message: "Data has been updated",
                              )..show(context);
                              _enabled = !_enabled;
                              currentPass.text = '';
                              textNewPass.clear();
                              textNewPass2.clear();
                              currentPass.clear();
                              error = null;
                              Navigator.pop(context);
                            })
                          : showDialog(
                              barrierDismissible: false,
                              context: context,
                              child: AlertDialog(
                                title: Text(
                                    'Please Insert Your Current Password !'),
                                content: TextField(
                                  controller: currentPass,
                                  obscureText: true,
                                  // controller: currentPassword,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: mainColor,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: secondaryColor),
                                    ),
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    color: mainColor,
                                    child: Text("Confirm"),
                                    onPressed: () async {
                                      try {
                                        result = await auth
                                            .FirebaseAuth.instance.currentUser
                                            .reauthenticateWithCredential(
                                          auth.EmailAuthProvider.credential(
                                              email: email,
                                              password: currentPass.text),
                                        );
                                        print(result);
                                        Navigator.pop(context);
                                        setState(() {
                                          _enabled = !_enabled;
                                        });
                                      } catch (e) {
                                        print(e.toString());
                                        Flushbar(
                                          duration: Duration(seconds: 2),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message: "Invalid Password",
                                        )..show(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                    },
                    child: Text(
                      _enabled ? "Update Profile" : "Edit Profile",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
