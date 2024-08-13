import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class Background extends ParallaxComponent{
  Background();

  @override
  FutureOr<void> onLoad() async {
    parallax = await game.loadParallax([
      ParallaxImageData('background-day.png')
    ],
    baseVelocity: Vector2(10, 0)
    );
    return super.onLoad();
  }
}