part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class OnIntialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnGetStarted extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegis extends PageState {
  @override
  List<Object> get props => [];
}

class OnLiveChat extends PageState {
  final Doctor doctor;

  OnLiveChat(this.doctor);

  @override
  List<Object> get props => [doctor];
}

class OnDoctorDetail extends PageState {
  final Doctor doctor;

  OnDoctorDetail(this.doctor);
  @override
  List<Object> get props => [doctor];
}

class OnLiveDoctor extends PageState {
  final User user;

  OnLiveDoctor(this.user);
  @override
  List<Object> get props => [user];
}
