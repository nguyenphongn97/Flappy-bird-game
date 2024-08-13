import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/item.dart';
import 'package:flappy_bird/utils/config.dart';

import 'pipe.dart';

class GroupPipeComponent extends PositionComponent with HasGameReference{
  GroupPipeComponent();

  final random = Random();

  @override
  FutureOr<void> onLoad() {

    position.x = game.size.x;
    const space = 290;
    double centerY = random.nextDouble()* (game.size.y - Config.heightGround - space) + space*0.5;

    if(centerY < 110){
      centerY = 110;
    }
    const minHeight = 120+ space*0.5;
    double height = max(centerY - space*0.5, minHeight);
    PipeComponent topPipe = PipeComponent(isTop: true, pipeHeight: height);
    PipeComponent bottomPipe =  PipeComponent(isTop: false, pipeHeight: game.size.y - Config.heightGround - height - space * 0.5);
    ItemComponent itemComponent = ItemComponent(mSize: Vector2(10, 150))..position.y = height;
    addAll([
      topPipe, bottomPipe, itemComponent
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= Config.gameSpeed*dt;

    if(position.x < -60){
      removeFromParent();
    }
    super.update(dt);
  }
}