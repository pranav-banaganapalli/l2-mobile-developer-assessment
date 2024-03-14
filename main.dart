import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balloon Pop Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BalloonPopGame(),
    );
  }
}

class BalloonPopGame extends StatefulWidget {
  @override
  _BalloonPopGameState createState() => _BalloonPopGameState();
}

class _BalloonPopGameState extends State<BalloonPopGame> {
  int score = 0;
  int timeRemaining = 120; // 2 minutes in seconds
  bool gameStarted = false;

  void startGame() {
    setState(() {
      gameStarted = true;
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeRemaining > 0) {
          setState(() {
            timeRemaining--;
          });
        } else {
          timer.cancel();
          gameStarted = false;
        }
      });
    });
  }

  void popBalloon() {
    setState(() {
      score += 2;
    });
  }

  void missBalloon() {
    setState(() {
      score -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balloon Pop Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Remaining: ${timeRemaining ~/ 60}:${(timeRemaining % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            if (!gameStarted)
              ElevatedButton(
                onPressed: startGame,
                child: Text('Start Game'),
              ),
            if (gameStarted)
              GestureDetector(
                onTap: popBalloon,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}