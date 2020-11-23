import 'package:flutter/material.dart';
import '../bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../custom_colour.dart';

class GameInitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('2048', style: TextStyle(fontSize: 50.0, color: Colors.purple),),
                SizedBox(height: 50.0,),
                Container(
                  width: 120.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => BlocProvider.of<ScreenBloc>(context).add(Goto3()),
                    color: Theme.of(context).colorScheme.colour4,
                    child: Text('3 x 3', style: TextStyle(color: Colors.white, fontSize: 25.0),),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 120.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => BlocProvider.of<ScreenBloc>(context).add(Goto4()),
                    color: Theme.of(context).colorScheme.colour4,
                    child: Text('4 x 4', style: TextStyle(color: Colors.white, fontSize: 25.0),),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}