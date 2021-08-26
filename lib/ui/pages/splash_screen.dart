part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isLoading = true;
        /* Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Wrapper();
        })); */
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Wrapper() : splash(context);
  }

  Widget splash(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFFFFDE03),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/img/logohc.png"),
                    fit: BoxFit.contain,
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Health Care",
                    style: TextStyle(
                        fontSize: 28,
                        color: mainColor,
                        fontFamily: 'NunitoExtraBold'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
