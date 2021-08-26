part of 'pages.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return isLoading
        ? Container(
            color: secondaryColor,
            child: SpinKitFadingCircle(color: mainColor),
          )
        : getStartedLoading(context);
  }

  Widget getStartedLoading(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/getstarted.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/img/logohc.png"),
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Health Care',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'NunitoBold',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your health is in our care',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFFffffac),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 280.0,
                          height: 45.0,
                          buttonColor: mainColor,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              context.bloc<PageBloc>().add(GoToRegis());
                            },
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ButtonTheme(
                          minWidth: 280.0,
                          height: 45.0,
                          buttonColor: Colors.white,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              context.bloc<PageBloc>().add(GoToLoginPage());
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                        ),
                        SizedBox(height: 44),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
