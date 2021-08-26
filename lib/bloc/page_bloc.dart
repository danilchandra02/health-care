import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_care/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnIntialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToGetStarted) {
      yield OnGetStarted();
    } else if (event is GoToRegis) {
      yield OnRegis();
    } else if (event is GoToLiveChat) {
      yield OnLiveChat(event.doctor);
    } else if (event is GoToDoctorDetail) {
      yield OnDoctorDetail(event.doctor);
    } else if (event is GoToLiveDoctor) {
      yield OnLiveDoctor(event.user);
    }
  }
}
