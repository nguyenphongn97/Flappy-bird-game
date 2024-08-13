import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/player.dart';

class ItemComponent extends PositionComponent with CollisionCallbacks{
  Vector2 mSize;
  ItemComponent({ required this.mSize}):super(){
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(size: mSize));
    return super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if(other is Player){
      other.score ++;
      removeFromParent();
      FlameAudio.play('point.wav');
    }
    super.onCollisionEnd(other);
  }
}