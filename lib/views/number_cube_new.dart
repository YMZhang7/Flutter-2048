import 'package:flutter/material.dart';

class NumberCubeNew extends StatefulWidget {
  final int number;
  const NumberCubeNew({Key key, this.number}):super(key: key);
  @override
  _NumberCubeNewState createState() => _NumberCubeNewState();
}

class _NumberCubeNewState extends State<NumberCubeNew> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState(){
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(widget.number.toString(), style: TextStyle(fontSize: 40),),
        alignment: Alignment.center,
      ),
    );
  }
}