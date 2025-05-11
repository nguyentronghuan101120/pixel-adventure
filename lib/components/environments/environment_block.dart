import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/configs/enviroment_config.dart';

class EnvironmentBlock extends PositionComponent {
  EnvironmentBlock(
      {required Vector2 position, required Vector2 size, required this.type})
      : super(position: position, size: size);

  final EnvironmentBlockEnum type;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(RectangleHitbox(isSolid: true));
  }
}
