import 'package:flappy_bird/main.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  final FlappyBirdGame flappyBirdGame;
  const GameOverOverlay({super.key, required this.flappyBirdGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/gameover.png'),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {
                flappyBirdGame.overlays.remove('gameOver');
                flappyBirdGame.player.resetGame();
                flappyBirdGame.resumeEngine();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text(
                'Restart',
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Game'),
              ))
        ],
      ),
    );
  }
}
