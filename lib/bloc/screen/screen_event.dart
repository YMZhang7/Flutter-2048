import 'package:equatable/equatable.dart';

abstract class ScreenEvent extends Equatable {
  const ScreenEvent();

  @override
  List<Object> get props => [];
}

class Goto3 extends ScreenEvent {}

class Goto4 extends ScreenEvent {}

class GotoWonScreen extends ScreenEvent {}

class GotoFailedScreen extends ScreenEvent {}

class QuitGame extends ScreenEvent {}
