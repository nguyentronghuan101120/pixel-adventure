import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Hole extends PositionComponent
    with HasGameReference<PixelAdventure>, CollisionCallbacks {
  Hole({required super.position, required super.size});

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Character) {
      other.respawn();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
