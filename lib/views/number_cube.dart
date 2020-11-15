import 'dart:async';

import 'package:flutter/material.dart';

class NumberCube extends StatefulWidget {
  final int number;
  final bool isNew;
  const NumberCube ({ Key key,@required this.number,@required this.isNew}): super(key: key);
  @override
  _NumberCubeState createState() => _NumberCubeState();
}

class _NumberCubeState extends State<NumberCube> {
  Timer _timer;
  bool change = false;
  

  _NumberCubeState(){
    _timer = new Timer(const Duration(seconds: 2), (){
      setState(() {
        change = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if (widget.number != 0){
      if (widget.isNew){
        print('hhhhhhhhhhhh');
        return AnimatedContainer(
          duration: Duration(seconds: 5),
          width: change? 0 : 100,
          height: change? 0 : 100,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(widget.number.toString(), style: TextStyle(fontSize: 40),),
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
          child: Text(widget.number.toString(), style: TextStyle(fontSize: 40),),
          alignment: Alignment.center,
        );
      }
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

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}