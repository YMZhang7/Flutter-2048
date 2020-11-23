import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/blocs.dart';
import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ScreenBloc(),
        child: ScreensManager()
      ),
    );
  }
}

class ScreensManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenBloc, ScreenState>(
      builder: (context, state){
        if (state is ScreenInitial){
          return GameInitialScreen();
        } else if (state is ScreenFailed){
          return GameFailedScreen();
        } else if (state is ScreenGame3){
          return BlocProvider(
            create: (context) => Play3Bloc(),
            child: GameBoard3(),
          );
        } else if (state is ScreenGame4){
          return BlocProvider(
            create: (context) => Play4Bloc(),
            child: GameBoard4(),
          );
        } else if (state is ScreenWon){
          return Container(height: 0.0, width: 0.0,);
        } else {
          return Container(height: 0.0, width: 0.0,);
        }
      },
    );
  }
}
