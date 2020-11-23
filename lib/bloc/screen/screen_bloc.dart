import 'dart:async';

import 'package:bloc/bloc.dart';

import '../blocs.dart';


class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(ScreenInitial());

  @override
  Stream<ScreenState> mapEventToState(
    ScreenEvent event,
  ) async* {
    if (event is Goto3){
      yield ScreenGame3();
    } else if (event is Goto4){
      yield ScreenGame4();
    } else if (event is GotoWonScreen){
      yield ScreenWon();
    } else if (event is GotoFailedScreen){
      yield ScreenFailed();
    } else if (event is QuitGame){
      yield ScreenInitial();
    }
  }
}
