part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToGetStarted extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegis extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLiveChat extends PageEvent {
  final Doctor doctor;
  GoToLiveChat(this.doctor);
  @override
  List<Object> get props => [doctor];
}

class GoToDoctorDetail extends PageEvent {
  final Doctor doctor;
  GoToDoctorDetail(this.doctor);
  @override
  List<Object> get props => [doctor];
}

class GoToLiveDoctor extends PageEvent {
  final User user;
  GoToLiveDoctor(this.user);
  @override
  List<Object> get props => [user];
}
