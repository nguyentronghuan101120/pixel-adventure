import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/checkpoint_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Checkpoint extends SpriteAnimationGroupComponent
    with HasGameReference<PixelAdventure>, CollisionCallbacks {
  Checkpoint({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    animations = {
      for (final status in CheckpointStatus.values)
        status: _animationLoad(status)
    };

    current = CheckpointStatus.noFlag;

    add(RectangleHitbox(
      size: Vector2(12, 50),
      position: Vector2(18, size.y - 50),
    ));

    return super.onLoad();
  }

  SpriteAnimation _animationLoad(CheckpointStatus status) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Items/Checkpoints/Checkpoint/${status.value}"),
      SpriteAnimationData.sequenced(
        amount: status.animationSequenceAmount,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
        loop: status == CheckpointStatus.idle,
      ),
    );
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Character && current != CheckpointStatus.idle) {
      other.complete();

      current = CheckpointStatus.out;

      await animationTicker?.completed;

      current = CheckpointStatus.idle;
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
