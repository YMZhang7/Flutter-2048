import 'package:equatable/equatable.dart';

abstract class PlayEvent extends Equatable{
  const PlayEvent();
  @override
  List<Object> get props => [];
}

class GameBegins extends PlayEvent{}

class SwipeLeft extends PlayEvent{}

class SwipeRight extends PlayEvent{}

class SwipeUp extends PlayEvent{}

class SwipeDown extends PlayEvent{}
