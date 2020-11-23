import 'package:equatable/equatable.dart';

abstract class Play3Event extends Equatable{
  const Play3Event();
  @override
  List<Object> get props => [];
}

class GameBegins3 extends Play3Event{}

// class GameBegins4 extends PlayEvent {}

class SwipeLeft3 extends Play3Event{}

class SwipeRight3 extends Play3Event{}

class SwipeUp3 extends Play3Event{}

class SwipeDown3 extends Play3Event{}

class GetPreviousState3 extends Play3Event{}