import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game/character.dart';
import 'package:game/obstacles.dart';

class Flappy extends StatefulWidget {
  @override
  
  var height, width;
  _FlappyState createState() => _FlappyState();
}

class _FlappyState extends State<Flappy> {
  
  double birdWidth = 0.2;
  double birdHeight = 0.2;
  static List<double> barrierX = [2, 2, 3, 3];
  static double barrierWidth = 0.16;
  List<double> barrierHeight = [0.6, 0.4, 0.4, 0.6];
  List<double> barrierypos = [0.65, -1, 0.65, -1];
  List<bool> boolean = [false, true, false, true];
  double birdYaxis = 0;
  double speed = 0.2;
  double height = 0;
  int score = 0;
  int bestscore = 0;
  bool isPlaying = false;
  int count = 0;
  String path = "images/flappy.gif";
  double time = 0;
  double gravity = 5;
  double initialheight = 0;



  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        if (isPlaying) {
          if (birdYaxis>=-0.91)
          {
          jump();
          }
        } else if (collision() ) {
          score = 0;
          count = 0;
          barrierX = [2, 2, 3, 3];
          barrierypos = [0.7, -1, 0.7, -1];

          boolean = [false, true, false, true];
          startGame();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Color.fromARGB(255, 59, 177, 255),
                child: Center(
                  child: Stack(
                    children: [
                      MyCharacter(
                          birdX: 0,
                          birdY: birdYaxis,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
                          path: path),
                      Container(
                        alignment: Alignment(0, -0.3),
                        child: isPlaying ? Text("") : Text("TAP TO PLAY!!!"),
                      ),
                      MyObstacles(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0],
                          barrierX: barrierX[0],
                          isThisbottom: boolean[0]),
                      MyObstacles(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1],
                          barrierX: barrierX[1],
                          isThisbottom: boolean[1]),
                      MyObstacles(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[2],
                          barrierX: barrierX[2],
                          isThisbottom: boolean[2]),
                      MyObstacles(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[3],
                          barrierX: barrierX[3],
                          isThisbottom: boolean[3]),
                    ],
                  ),
                ),
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            flex: 1,
            child: Container(
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("SCORE",
                            style: TextStyle(color: Colors.red, fontSize: 32)),
                        SizedBox(height: 20, width: 25),
                        Text(score.toString(), style: TextStyle(fontSize: 40))
                      ],
                    ),
                    Column(
                      children: [
                        RaisedButton(
                            child: isPlaying ? Text("") : Text("QUIT"),
                            color: isPlaying ? Colors.yellow : Colors.blue,
                            onPressed: () {
                              isPlaying ? "" : Navigator.pop(context);
                            })
                      ],
                    ),
                    Column(
                      children: [
                        Text("BEST",
                            style: TextStyle(color: Colors.red, fontSize: 32)),
                        SizedBox(height: 20, width: 25),
                        Text(bestscore.toString(),
                            style: TextStyle(fontSize: 40))
                      ],
                    ),
                  ],
                )),
          ),
        ],
      )),
    );
  }
    void startGame() {
    isPlaying = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        time += 0.03;
        speed += 0.002;
        height = -gravity * time * time + 3 * time;
        birdYaxis = initialheight - height;
        if (birdYaxis <= -1) {
          birdYaxis = -1;
        }
        if (birdYaxis >= 0.8) {
          birdYaxis=0.8;
          // collision() = true;
        }
        for (int i = 0; i <= 3; i++) {
          barrierX[i] -= 0.03;
          if (barrierX[i] <= -1.5) {
            barrierX[i] = 0.9;
          }
        }
      });
      score += 1;
      if (bestscore < score) {
        bestscore = score;
      }
      if (collision() ) {
        timer.cancel();
        isPlaying = false;
        // startGame();
      }
    });
  }

    void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  bool collision() {
    for (int i = 0; i < barrierX.length; i++) {
      if (0 < barrierX[i] + barrierWidth &&
          0 + birdWidth / 2 > barrierX[i] &&
          birdYaxis < barrierHeight[i] + barrierypos[i] &&
          birdHeight + birdYaxis > barrierypos[i]) {
        return true;
      }
    }
    return false;
  }
}
