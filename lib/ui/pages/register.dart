part of 'pages.dart';

class Register extends StatefulWidget {
  final RegistrationData registrationData;

  Register({this.registrationData});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  String dobController;

  bool isSigningUp = false;

  @override
  void initState() {
    super.initState();
    /* emailController.text = widget.registrationData.email;
    nameController.text = widget.registrationData.name; */
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToGetStarted());
        return;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/bgc.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            // color: Colors.red,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  child: new AppBar(
                    backgroundColor:
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? Color(0x00000000)
                            : mainColor,
                    title: new Text(
                      "Registration",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        context.bloc<PageBloc>().add(GoToGetStarted());
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: secondaryColor),
                                    ),
                                    hintText: 'Enter a full name',
                                    labelText: "Full Name",
                                    labelStyle: TextStyle(color: mainColor),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: mainColor,
                                    ),
                                  ),
                                  maxLength: 25,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: mainColor),
                                  ),
                                  child: DateTimePicker(
                                    icon: Icon(
                                      Icons.date_range,
                                      color: mainColor,
                                    ),
                                    dateMask: 'd MMM, yyyy',
                                    initialValue: '',
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Date of Birth',
                                    onChanged: (val) => dobController = val,
                                  ),
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: mainColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                    hintText: 'Enter an email address',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: "Email Address",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: mainColor,
                                    ),
                                  ),
                                  maxLength: 40,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: mainColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                    hintText: 'Enter a password',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: mainColor,
                                    ),
                                  ),
                                  maxLength: 20,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextField(
                                  controller: cPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: mainColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0),
                                    ),
                                    hintText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: "Confirm Password",
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: mainColor,
                                    ),
                                  ),
                                  maxLength: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 280.0,
                              height: 45.0,
                              buttonColor: Color(0xFFD6b911),
                              child: isSigningUp
                                  ? SpinKitFadingCircle(
                                      color: mainColor,
                                    )
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () async {
                                        if (!(nameController.text.trim() !=
                                                "" &&
                                            dobController.trim() != "" &&
                                            emailController.text.trim() != "" &&
                                            passwordController.text.trim() !=
                                                "" &&
                                            cPasswordController.text.trim() !=
                                                "")) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message:
                                                "Please fill all the fields",
                                          )..show(context);
                                        } else if (passwordController.text !=
                                            cPasswordController.text) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message:
                                                "passwords do not match",
                                          )..show(context);
                                        } else if (passwordController
                                                .text.length <=
                                            5) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message:
                                                "Password's length min 6 characters",
                                          )..show(context);
                                        } else if (!EmailValidator.validate(
                                            emailController.text)) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message:
                                                "Wrong formatted email address",
                                          )..show(context);
                                        } else {
                                          setState(() {
                                            isSigningUp = true;
                                          });
                                          SignInSignUpResult result =
                                              await AuthServices.signUp(
                                                  emailController.text,
                                                  passwordController.text,
                                                  nameController.text,
                                                  "",
                                                  dobController);
                                          if (result.user == null) {
                                            setState(() {
                                              isSigningUp = false;
                                            });
                                            Flushbar(
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              message:
                                                  "The Email Address is already in use by another account.",
                                            )..show(context);
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Get Signed Up",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mainColor,
                                            fontFamily: 'NunitoBold'),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
