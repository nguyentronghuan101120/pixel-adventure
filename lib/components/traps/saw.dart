import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/trap_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'dart:math' as math;

class Saw extends SpriteAnimationComponent
    with HasGameReference<PixelAdventure>, CollisionCallbacks {
  Saw({
    required Vector2 position,
    required Vector2 size,
    required this.type,
    required this.moveRangeTiles,
    required this.isVerticalMove,
  }) : super(position: position, size: size) {
    originalPosition = position.clone();
    phaseOffset = math.Random().nextDouble() * 2 * math.pi;
  }

  final TrapType type;
  final int moveRangeTiles;
  final bool isVerticalMove;
  final int moveSpeed = 1;
  late Vector2 originalPosition;
  double time = 0;
  late double phaseOffset;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    _loadAnimation();

    add(CircleHitbox());
    return super.onLoad();
  }

  void _loadAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Traps/${type.value}/${type.actionAnimation}.png'),
      SpriteAnimationData.sequenced(
        amount: type.animationAmount,
        stepTime: type.animationStepTime,
        textureSize: Vector2(type.textureSizeWidth, type.textureSizeHeight),
      ),
    );
  }

  @override
  void update(double dt) {
    time += dt;

    const double tileSize = 16;
    final offset =
        moveRangeTiles * tileSize * math.sin(time * moveSpeed + phaseOffset);

    if (isVerticalMove) {
      position.y = originalPosition.y + offset;
    } else {
      position.x = originalPosition.x + offset;
    }

    super.update(dt);
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
