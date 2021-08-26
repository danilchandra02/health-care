part of 'pages.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSiginingIn = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
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
            //color: Color(0xFFEFEFEF),
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
                      "Login",
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
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Image(
                        image: AssetImage("assets/img/logohc.png"),
                        fit: BoxFit.contain,
                        width: 96,
                        height: 85,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    "Log in and start consultation",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 20,
                                      fontFamily: 'NunitoBold',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      isEmailValid =
                                          EmailValidator.validate(text);
                                    });
                                  },
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
                                  onChanged: (text) {
                                    setState(() {
                                      isPasswordValid = text.length >= 6;
                                    });
                                  },
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
                                  height: 30,
                                )
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
                              buttonColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              child: isSiginingIn
                                  ? SpinKitFadingCircle(
                                      color: mainColor,
                                    )
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: isEmailValid && isPasswordValid
                                          ? () async {
                                              setState(() {
                                                isSiginingIn = true;
                                              });

                                              SignInSignUpResult result =
                                                  await AuthServices.signIn(
                                                      emailController.text,
                                                      passwordController.text);

                                              if (result.user == null) {
                                                setState(() {
                                                  isSiginingIn = false;
                                                });

                                                Flushbar(
                                                  duration:
                                                      Duration(seconds: 4),
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  backgroundColor:
                                                      Color(0xFFFF5C83),
                                                  message:
                                                      "Invalid username or password",
                                                )..show(context);
                                              }
                                            }
                                          : null,
                                      child: Text(
                                        "Sign In Now",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: isEmailValid && isPasswordValid
                                              ? Color(0xFFFFFFFF)
                                              : Color(0xFFBEBEBE),
                                          fontFamily: 'Nunito',
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToRegis());
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Create New Account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
