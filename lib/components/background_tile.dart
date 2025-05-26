import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/configs/background_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class BackgroundTile extends ParallaxComponent<PixelAdventure> {
  BackgroundTile();

  final random = Random();

  @override
  FutureOr<void> onLoad() async {
    final color =
        BackgroundColor.values[random.nextInt(BackgroundColor.values.length)];

    priority = -10;
    size = Vector2.all(64);
    parallax = await game.loadParallax([
      ParallaxImageData('Background/${color.value}.png'),
    ],
        baseVelocity:
            Vector2(random.nextDouble() * 100, random.nextDouble() * 100),
        repeat: ImageRepeat.repeat,
        fill: LayerFill.none);
    return super.onLoad();
  }
}
