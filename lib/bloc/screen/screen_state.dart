import 'package:equatable/equatable.dart';

abstract class ScreenState extends Equatable {
  const ScreenState();
  @override
  List<Object> get props => [];
}

// Homescreen
class ScreenInitial extends ScreenState {}

class ScreenGame3 extends ScreenState {}

class ScreenGame4 extends ScreenState {}

class ScreenWon extends ScreenState {}

class ScreenFailed extends ScreenState {}