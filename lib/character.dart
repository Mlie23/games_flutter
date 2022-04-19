import 'package:flutter/material.dart';

class MyCharacter extends StatelessWidget{
  final birdX;
  final birdY;
  final double birdWidth;
  final double birdHeight;
  final String path;
  MyCharacter({
    this.birdX,
    this.birdY,
    required this.birdWidth,
    required this.birdHeight,
    required this.path
  });

  @override 
  Widget build(BuildContext context)
  {
    return Container(
      alignment: Alignment(0,(2*birdY+birdHeight)/(2-birdHeight)),
      child: Image.asset(path,
      width: MediaQuery.of(context).size.height * birdWidth/2,
      height: MediaQuery.of(context).size.height*3/4*birdHeight/2,
      fit:BoxFit.fill
    ));
  }
}