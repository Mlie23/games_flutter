import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game/character.dart';
import 'package:game/obstacles.dart';
import 'dart:math';

// Additional packages:
// 1. dart:async -> (timer-usage for graphic reloading)
// 2.   flutter_launcher_icons -> changing app name and icoon



class Gravity extends StatefulWidget {
  @override
  _GravityState createState() => _GravityState();
}

class _GravityState extends State<Gravity> {
  double birdWidth = 0.2;
  double birdHeight = 0.3;
  static List<double> barrierX = [2, 2.5, 3, 3.5];
  static double barrierWidth = 0.1;
  List<double> barrierHeight = [0.5, 0.5, 0.5, 0.5];
  List<double> barrierypos = [0.7, -1, 0.7, -1];
  List<bool> boolean = [false, true, false, true];
  static double birdYaxis = -1;
  double speed = 0.2;
  double acceleration = 0;
  double height = 0;
  int score = 0;
  int bestscore = 0;
  bool isPlaying = false;
  int count = 0;
  String path = "images/running.gif";


  // Jump function to change which way to jump (up or down)
  // Change the image path as well
  void jump() {
    setState(() {
      if (count == 0) {
        count = 1;
        path = "images/flipped_running.gif";
      } else {
        count = 0;
        path = "images/running.gif";
      }
    });
  }

  // Checking collision function
  // As long as there is gab between two objects, return false
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

  // Check if birdstate is in up and down
  // else: disable jump function
  bool canMove() {
    if (birdYaxis == -1 || birdYaxis == 0.70) {
      return true;
    }
    return false;
  }


  // Timer starts
  void startGame() {
    isPlaying = true;
    // every 50 milisecond, state is repeated
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        acceleration +=0.00005;
        // Setting up which direction the character is jumping based on count (flip-flops)
        if (count % 2 == 1) {
          birdYaxis = birdYaxis - speed;
        } else {
          birdYaxis = birdYaxis + speed;
        }

        // Checking upper and lower bounds (keep the character either top or low)
        if (birdYaxis >= 0.70) {
          birdYaxis = 0.70;
        }
        if (birdYaxis <= -1) {
          birdYaxis = -1;
        }


        // Move all the barrier positions every refresh rate
        for (int i = 0; i <= 3; i++) {
          barrierX[i] -= (0.03+acceleration);
          // If it hits most left, restart the barrier positions
          if (barrierX[i] <= -1.5) {
            var random = Random();
            barrierX[i] = 2.0 + (random.nextInt(3)*0.1+0.3);
            boolean[i] = random.nextBool();
            if (boolean[i] == false) {
              barrierypos[i] = 0.7;
            } else {
              barrierypos[i] = -1;
            }
          }
        }
      });
      // Increment score and change bestscore
      score += 1;
      if (bestscore < score) {
        bestscore = score;
      }
      // Check collision
      if (collision()) {
        timer.cancel();
        isPlaying = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tap detection
    return GestureDetector(
      onTap: () {
        // if game ongoing and player can move, implement jump
        if (isPlaying && canMove()) {
          jump();
        // if collide
        // Next tap: "restart the game"
        } else if (collision()) {
          score = 0;
          count = 0;
          barrierX = [2, 2.5, 3, 3.5];
          barrierypos = [0.7, -1, 0.7, -1];
          boolean = [false, true, false, true];
          path = "images/running.gif";
          startGame();
        // If not playing e.g. first load, ontap = play
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
                            color: isPlaying ?Colors.yellow:Colors.blue,
                            onPressed: () {
                              isPlaying ?"": Navigator.pop(context);
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
}
