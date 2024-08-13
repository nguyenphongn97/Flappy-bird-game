import 'package:flutter/material.dart';

import '../main.dart';

class StartGameOverlay extends StatelessWidget {
  final FlappyBirdGame flappyBirdGame;
  const StartGameOverlay({super.key, required this.flappyBirdGame});

  @override
  Widget build(BuildContext context) {
    flappyBirdGame.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          flappyBirdGame.overlays.remove('Startgame');
          flappyBirdGame.player.resetGame();
          flappyBirdGame.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background-day.png'), fit: BoxFit.fill)
          ),
          child: Image.asset('assets/images/message.png'),
        ),
      ),
    );
  }
}