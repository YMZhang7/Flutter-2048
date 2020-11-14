import 'package:flutter/material.dart';
import '../bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start the Game!',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
              child: Text('Start'),
            )
          ],
        ),
    );
  }
}