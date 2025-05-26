import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/fruit_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameReference<PixelAdventure>, CollisionCallbacks {
  Fruit({required Vector2 position, required Vector2 size, required this.fruit})
      : super(position: position, size: size);

  final FruitName fruit;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    _loadAnimation();
    add(
      RectangleHitbox(
        size: Vector2(12, 12),
        position: Vector2(10, 10),
      ),
    );
    return super.onLoad();
  }

  void _loadAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(
        'Items/Fruits/${fruit.value}.png',
      ),
      SpriteAnimationData.sequenced(
        amount: 17,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Character) {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
          'Items/Fruits/Collected.png',
        ),
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.05,
            textureSize: Vector2.all(32),
            loop: false),
      );

      await animationTicker?.completed;

      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
