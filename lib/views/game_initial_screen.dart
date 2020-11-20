import 'package:flutter/material.dart';
import '../bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../custom_colour.dart';

class GameInitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.colour2,
      width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start the Game!',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.5),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () => BlocProvider.of<PlayBloc>(context).add(GameBegins()),
              color: Theme.of(context).colorScheme.colour4,
              child: Text('Start', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
    );
  }
}