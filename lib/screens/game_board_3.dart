import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/bloc/blocs.dart';
import 'package:game/components/components.dart';
import 'package:game/models/board.dart';
import 'package:swipedetector/swipedetector.dart';

class GameBoard3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<Play3Bloc, Play3State>(
        builder: (context, state) {
          if (state is PlayInitial3){
            BlocProvider.of<Play3Bloc>(context).add(GameBegins3());
            return Container(width: 0.0, height: 0.0,);
          } else if (state is PlayInProcess13 || state is PlayInProcess23 || state is PlayStart3){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: SwipeDetector(
                    onSwipeUp: () {
                      BlocProvider.of<Play3Bloc>(context).add(SwipeUp3());
                      print('swiped up');
                    } ,
                    onSwipeDown: () {
                      BlocProvider.of<Play3Bloc>(context).add(SwipeDown3());
                      print('swiped down');
                    },
                    onSwipeLeft: () {
                      BlocProvider.of<Play3Bloc>(context).add(SwipeLeft3());
                      print('swiped left');
                    },
                    onSwipeRight: () {
                      BlocProvider.of<Play3Bloc>(context).add(SwipeRight3());
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
                        color: Colors.black,
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
                        BlocProvider.of<ScreenBloc>(context).add(QuitGame());
                      },
                      padding: const EdgeInsets.all(0.0),
                      child: Text('Exit', style: TextStyle(fontSize: 20),),
                      color: Colors.red,
                    ),
                    RaisedButton(
                      onPressed: (){
                        BlocProvider.of<Play3Bloc>(context).add(GetPreviousState3());
                        print('hhhh');
                      },
                      color: Colors.lightGreen,
                      child: Text('Back', style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
              ],
            );
          } else if (state is PlayFailed3){
            BlocProvider.of<ScreenBloc>(context).add(GotoFailedScreen());
          } else {
            return Container(width: 0.0, height: 0.0,);
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