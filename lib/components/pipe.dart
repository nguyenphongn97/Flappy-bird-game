import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/utils/config.dart';

class PipeComponent extends SpriteComponent with HasGameReference, CollisionCallbacks{
  final bool isTop;
  final double pipeHeight;

  PipeComponent({required this.isTop, required this.pipeHeight}):super(){
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() async {
    final pipe = await Flame.images.load("pipe-green.png");
    size = Vector2(52, pipeHeight);
    if(isTop){
      flipVerticallyAroundCenter();
      position.y = pipeHeight;
      sprite = Sprite(pipe);
    }else{
      position.y = game.size.y - Config.heightGround - size.y;
      sprite = Sprite(pipe);
    }

    add(RectangleHitbox());
    return super.onLoad();
  }
}