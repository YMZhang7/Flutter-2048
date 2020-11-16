import 'package:flutter/material.dart';
import 'package:game/views/number_cube_new.dart';

class NumberCube extends StatelessWidget {
  final int number;
  final bool isNew;
  const NumberCube({this.number, this.isNew});
  @override
  Widget build(BuildContext context) {
    if (!isNew){
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
        );
      }
    } else {
      return NumberCubeNew(number: number,);
    }
  }
}