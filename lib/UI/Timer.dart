import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final String title;
  final int counter;
  Timer(this.title, this.counter);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin{
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(minutes: widget.counter));
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _animationController.forward();
    _animationController.addListener((){setState(()=>_animation.value);});
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Text('${_animation.value*widget.counter}',style: TextStyle(color: Colors.white),),
          Text('${widget.title}'),
        ],
      )
    );
  }
}
