part of 'pages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: secondaryColor,
            child: SpinKitFadingCircle(color: mainColor),
          )
        : homeLoading();
  }

  Widget homeLoading() => Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(
                color: Color(0xFFF6F7F9),
              ),
            ),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                });
              },
              children: [
                HomePage(),
                MyProfile(),
              ],
            ),
            createCustomBottomNavBar(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 46,
                width: 46,
                margin: EdgeInsets.only(bottom: 32),
                child: FloatingActionButton(
                  backgroundColor: mainColor,
                  elevation: 0,
                  child: SizedBox(
                    height: 26,
                    width: 26,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white.withOpacity(0.74),
                    ),
                  ),
                  onPressed: () {
                    AuthServices.signOut();
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget messagesPage1() => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/img/construction.png"),
                fit: BoxFit.cover,
                width: 240,
                height: 240,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sorry, we are under construction",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF112340),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Color(0xFFFFDE03),
              selectedItemColor: mainColor,
              unselectedItemColor: Color(0xFF495A75).withOpacity(.70),
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    "Home",
                    style: TextStyle(
                      fontFamily: 'NunitoExtraBold',
                      fontSize: 15,
                    ),
                  ),
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: 'NunitoExtraBold',
                      fontSize: 15,
                    ),
                  ),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
