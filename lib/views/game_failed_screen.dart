import 'package:flutter/material.dart';
import '../bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.lightGreen.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Game Over'),
          SizedBox(height: 30,),
          RaisedButton(
            onPressed: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
            child: Text('Restart'),
          ),
          SizedBox(height: 5,),
          RaisedButton(
            onPressed: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
            child: Text('Quit'),
          ),
        ],
      ),
    );
  }
}