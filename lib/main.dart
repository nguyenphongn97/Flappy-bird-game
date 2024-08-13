import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/group_pipe.dart';
import 'package:flappy_bird/components/player.dart';
import 'package:flappy_bird/overlays/start_game_overlay.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/ground.dart';
import 'overlays/game_over_overlay.dart';

void main() {
  runApp(GameWidget(
    game: FlappyBirdGame(),
    overlayBuilderMap: {
      'Startgame': (context, FlappyBirdGame game){
        return StartGameOverlay(flappyBirdGame: game,);
      },
      'gameOver': (context, FlappyBirdGame game){
        return GameOverOverlay(flappyBirdGame: game,);
      },
    },
    initialActiveOverlays: const ['Startgame'],
  ));
}

class FlappyBirdGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Player player;
  double elapseTimePipe = 0.0;
  late TextComponent scoreText;

  @override
  FutureOr<void> onLoad() {
    add(Background());
    add(Ground());
    add(player = Player());
    add(scoreText = addScore());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (elapseTimePipe > 2.0) {
      add(GroupPipeComponent());
      elapseTimePipe = 0.0;
    }
    elapseTimePipe += dt;
    scoreText.text = 'Score: ${player.score}';

    super.update(dt);
  }

  void removePipe(){
    for(var node in children){
      if(node is GroupPipeComponent){
        node.removeFromParent();
      }
    }
  }

  TextComponent addScore(){
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x*0.5, 80),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'game',
          color: Colors.white
        )
      )
    );
  }

  @override
  void onTap() {
    player.touchFly();
    super.onTap();
  }
}
