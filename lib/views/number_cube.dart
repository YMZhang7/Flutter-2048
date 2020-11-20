import 'package:flutter/material.dart';
import 'package:game/views/number_cube_new.dart';
import '../custom_colour.dart';

class NumberCube extends StatelessWidget {
  final int number;
  final bool isNew;
  const NumberCube({this.number, this.isNew});
  @override
  Widget build(BuildContext context) {
    if (!isNew){
      if (number != 0){
        return buildCube(context, number);
      } else {
        return Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        );
      }
    } else {
      return NumberCubeNew(number: number,);
    }
  }

  Widget buildCube(BuildContext context, int number){
    Color color;
    switch(number){
      case 2:
        color = Theme.of(context).colorScheme.cube1;
        break;
      case 4:
        color = Theme.of(context).colorScheme.cube2;
        break;
      case 8:
        color = Theme.of(context).colorScheme.cube3;
        break;
      case 16:
        color = Theme.of(context).colorScheme.cube4;
        break;
      default:
        color = Theme.of(context).colorScheme.cube5;
    }
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(number.toString(), style: TextStyle(fontSize: 40),),
      alignment: Alignment.center,
    );
  }
}