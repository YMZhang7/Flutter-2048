import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipedetector/swipedetector.dart';
import 'bloc/blocs.dart';
import 'views/screens.dart';
import 'models/board.dart';

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
      body: BlocBuilder<PlayBloc, PlayState>(
        builder: (context, state) {
          if (state is PlayFailed){
            return GameFailedScreen();
          } else if (state is PlayInitial){
            return GameInitialScreen();
          } else {
            // PlayInProcess1 & 2
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                        color: Colors.grey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      height: 350,
                      width: 350,
                      child: getMatrix(state.board),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      onPressed: (){
                        BlocProvider.of<PlayBloc>(context).add(QuitGame());
                      },
                      padding: const EdgeInsets.all(0.0),
                      child: Text('Exit', style: TextStyle(fontSize: 20),),
                      color: Colors.red,
                    ),
                    RaisedButton(
                      onPressed: (){
                        BlocProvider.of<PlayBloc>(context).add(GetPreviousState());
                        print('hhhh');
                      },
                      color: Colors.lightGreen,
                      child: Text('Back', style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
              ],
            );
          }
        }
      ),
    );
    
  }

  Widget getMatrix(Board board){
    List<int> numbers = board.numbers;
    print(numbers);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberCube(number: numbers[0], isNew: 0 ==board.newNumberIndex,),
            NumberCube(number: numbers[1], isNew: 1 ==board.newNumberIndex),
            NumberCube(number: numbers[2], isNew: 2 ==board.newNumberIndex)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberCube(number: numbers[3], isNew: 3 ==board.newNumberIndex),
            NumberCube(number: numbers[4], isNew: 4 ==board.newNumberIndex),
            NumberCube(number: numbers[5], isNew: 5 ==board.newNumberIndex),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberCube(number: numbers[6], isNew: 6 ==board.newNumberIndex),
            NumberCube(number: numbers[7], isNew: 7 ==board.newNumberIndex),
            NumberCube(number: numbers[8], isNew: 8 ==board.newNumberIndex),
          ],
        ),
      ],
    );
  }
}
