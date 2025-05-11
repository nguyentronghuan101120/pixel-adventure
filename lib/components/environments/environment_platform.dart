import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnvironmentPlatform extends PositionComponent {
  EnvironmentPlatform({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(RectangleHitbox());
  }
}
