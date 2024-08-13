import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/utils/config.dart';

import '../main.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Player() : super() {
    debugMode = false;
  }
  var velocityBird = 0.0;
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    List<Sprite> spriteList = [
      await Sprite.load('yellowbird-downflap.png'),
      await Sprite.load('yellowbird-midflap.png'),
      await Sprite.load('yellowbird-upflap.png'),
    ];
    final anim = SpriteAnimation.spriteList(spriteList, stepTime: 0.15);
    size = Vector2(34, 24);

    position = Vector2(70, game.size.y / 2);
    animation = anim;

    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    addGravity(dt);
    super.update(dt);
  }

  void addGravity(double dt) {
    velocityBird += Config.gravity * dt;
    final newPosition = position.y + velocityBird * dt;
    position = Vector2(position.x, newPosition);

    anchor = Anchor.center;
    final anpha = clampDouble(velocityBird / 180, -pi * 0.25, pi * 0.25);
    angle = anpha;
  }

  void touchFly(){
    FlameAudio.play('wing.wav');
    velocityBird = -110;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground || other is PipeComponent) {
      FlameAudio.play('hit.wav');
      gameOver();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void gameOver(){
    game.pauseEngine();
    game.overlays.add('gameOver');
    FlameAudio.play('die.wav');
  }

  void resetGame(){
    game.removePipe();
    score = 0;
    position = Vector2(70, game.size.y / 2);
  }
}
