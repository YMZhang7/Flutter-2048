import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipedetector/swipedetector.dart';
import 'bloc/blocs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => PlayBloc(),
        child: GameDashBoard()
      ),
    );
  }
}

class GameDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // onTap: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
        child: BlocBuilder<PlayBloc, PlayState>(
          builder: (context, state) {
            if (state is PlayFailed){
              return GestureDetector(
                onTap: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
                child: Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text("You Failed", style: TextStyle(fontSize: 50),),
                ),
              );
            } else if (state is PlayInitial){
              return Container(
                color: Colors.lightBlue,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
                  child: Text("Tap to start playing", style: TextStyle(fontSize: 50),),
                ),
              );
            } else {
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: SwipeDetector(
                  onSwipeUp: () {
                    BlocProvider.of<PlayBloc>(context).add(SwipeUp());
                    print('swiped up');
                  } ,
                  onSwipeDown: () {
                    BlocProvider.of<PlayBloc>(context).add(SwipeDown());
                    print('swiped down');
                  },
                  onSwipeLeft: () {
                    BlocProvider.of<PlayBloc>(context).add(SwipeLeft());
                    print('swiped left');
                  },
                  onSwipeRight: () {
                    BlocProvider.of<PlayBloc>(context).add(SwipeRight());
                    print('swiped right');
                  },
                  swipeConfiguration: SwipeConfiguration(
                    verticalSwipeMinVelocity: 100.0,
                    verticalSwipeMinDisplacement: 30.0,
                    verticalSwipeMaxWidthThreshold:100.0,
                    horizontalSwipeMaxHeightThreshold: 100.0,
                    horizontalSwipeMinDisplacement:30.0,
                    horizontalSwipeMinVelocity: 100.0
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    height: 350,
                    width: 350,
                    child: getMatrix(state.numbers),
                  ),
                ),
              );
            }
          }
        ),
      ),
    );
    
  }

  Widget getMatrix(List<int> numbers){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cube(numbers[0]),
            cube(numbers[1]),
            cube(numbers[2])
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cube(numbers[3]),
            cube(numbers[4]),
            cube(numbers[5]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cube(numbers[6]),
            cube(numbers[7]),
            cube(numbers[8]),
          ],
        ),
      ],
    );
  }

  Widget cube(int number){
    if (number != 0){
      return Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(number.toString(), style: TextStyle(fontSize: 40),),
        alignment: Alignment.center,
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.center,
      );
    }
  }
}
