import 'package:flutter/material.dart';

class MyObstacles extends StatelessWidget
{
final barrierWidth;
final barrierHeight;
final barrierX;
final isThisbottom;

MyObstacles({
 this.barrierWidth,
 this.barrierHeight,
 this.barrierX,
 required this.isThisbottom
});

  @override 
  Widget build(BuildContext context)
  {
    return Container(
        alignment:Alignment((2*barrierX+barrierWidth) / (2-barrierWidth), isThisbottom ?-1:1),
        child: Container(
          color:Colors.green,
          width: MediaQuery.of(context).size.width*barrierWidth/2,
          height: MediaQuery.of(context).size.height*3/4*barrierHeight/2,
      ),
    );
  }
}