part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUSer = Provider.of<auth.User>(context);
    if (firebaseUSer == null) {
      if (!(prevPageEvent is GoToGetStarted)) {
        prevPageEvent = GoToGetStarted();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(id: firebaseUSer.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashScreen()
            : (pageState is OnGetStarted)
                ? GetStarted()
                : (pageState is OnLoginPage)
                    ? Login()
                    : (pageState is OnRegis)
                        ? Register()
                        : (pageState is OnLiveChat)
                            ? LiveChat(key, pageState.doctor)
                            : (pageState is OnDoctorDetail)
                                ? DoctorDetail(pageState.doctor)
                                : (pageState is OnLiveDoctor)
                                    ? LiveDoctor(key, pageState.user)
                                    : Home());
  }
}
