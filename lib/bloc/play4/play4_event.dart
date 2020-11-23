import 'package:equatable/equatable.dart';

abstract class Play4Event extends Equatable{
  const Play4Event();
  @override
  List<Object> get props => [];
}

// class GameBegins3 extends Play4Event{}

class GameBegins4 extends Play4Event {}

class SwipeLeft4 extends Play4Event{}

class SwipeRight4 extends Play4Event{}

class SwipeUp4 extends Play4Event{}

class SwipeDown4 extends Play4Event{}

// class QuitGame extends Play4Event{}

class GetPreviousState4 extends Play4Event{}