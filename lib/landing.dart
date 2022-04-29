import 'package:flutter/material.dart';
import 'package:game/gravity.dart';
import 'package:game/dogrun.dart';

import 'flappy.dart';
// import 'package:flutter_buttons/flutter_buttons.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
    return Scaffold(

      // appBar: AppBar(title: Text("Debug")),
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/flappy.gif", width:width/3,height: height/5,),
                Image.asset("images/wildwings.gif",width:width/3,height: height/5),
              ],
            ),
            IconButton(
              color: Color.fromARGB(255, 245, 3, 3),
              iconSize: height/15,
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Flappy()));
              },
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Image.asset("images/running.gif",width:width/3,height: height/5),
              Image.asset("images/doublegravity.gif",width:width/3,height: height/5),
            ]),
            IconButton(
              color: Color.fromARGB(255, 255, 2, 2),
              iconSize: height/15,
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Gravity()));
              },
            ),
              //           IconButton(
              // color: Color.fromARGB(255, 245, 3, 3),
              // iconSize: height/15,
              // icon: Icon(Icons.play_arrow),
              // onPressed: () {
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => DogRun()));
              // },
            // )
          ],
        ),
      ),
    );
  }
}
