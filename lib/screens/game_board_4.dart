import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/bloc/blocs.dart';
import 'package:game/components/number_cube.dart';
import 'package:game/models/board.dart';
import 'package:swipedetector/swipedetector.dart';

class GameBoard4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<Play4Bloc,Play4State>(
        builder: (context, state){
          if (state is PlayInitial4){
            BlocProvider.of<Play4Bloc>(context).add(GameBegins4());
            return Container(width: 0.0, height: 0.0,);
          } else if (state is PlayInProcess14 || state is PlayInProcess24 || state is PlayStart4){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: SwipeDetector(
                    onSwipeUp: () {
                      BlocProvider.of<Play4Bloc>(context).add(SwipeUp4());
                      print('swiped up');
                    } ,
                    onSwipeDown: () {
                      BlocProvider.of<Play4Bloc>(context).add(SwipeDown4());
                      print('swiped down');
                    },
                    onSwipeLeft: () {
                      BlocProvider.of<Play4Bloc>(context).add(SwipeLeft4());
                      print('swiped left');
                    },
                    onSwipeRight: () {
                      BlocProvider.of<Play4Bloc>(context).add(SwipeRight4());
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      height: 350,
                      width: 350,
                      // child: getMatrix(state.board),
                      child: Center(
                        child: BlocBuilder<Play4Bloc, Play4State>(
                          builder: (context, state) {
                            return GridView.count(
                              padding: EdgeInsets.all(0.0),
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              children: getMatrix(state.board),
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                            );
                          },
                        ),
                      ),
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
                        BlocProvider.of<Play4Bloc>(context).add(GetPreviousState4());
                        print('hhhh');
                      },
                      color: Colors.lightGreen,
                      child: Text('Back', style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
              ],
            );
          } else if (state is PlayFailed4){
            BlocProvider.of<ScreenBloc>(context).add(GotoFailedScreen());
            return Container(height: 0.0,width: 0.0,);
          } else {
            return Container(height: 0.0,width: 0.0,);
          }
        },
      ),
      
    );
  }

  List<Widget> getMatrix(Board board){
    List<Widget> result = [];
    for (int i = 0; i < board.numbers.length; i++){
      result.add(NumberCube(number: board.numbers[i], isNew: i == board.newNumberIndex));
    }
    return result;
  }
}