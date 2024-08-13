import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class Ground extends ParallaxComponent with CollisionCallbacks{
  Ground() : super(){
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() async {
    parallax = await game.loadParallax([
      ParallaxImageData('base.png')
    ],
      baseVelocity: Vector2(Config.gameSpeed.toDouble(), 0),
      fill: LayerFill.none,
      alignment: Alignment.bottomCenter
    );

    add(RectangleHitbox(
      position: Vector2(0, game.size.y - Config.heightGround),
      size: Vector2(game.size.x, Config.heightGround.toDouble())
    ));
    return super.onLoad();
  }
}