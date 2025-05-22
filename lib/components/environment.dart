import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/enviroment_config.dart';

class EnvironmentComponent extends PositionComponent with CollisionCallbacks {
  EnvironmentComponent(
      {required Vector2 position, required Vector2 size, required this.type})
      : super(position: position, size: size);

  final EnvironmentType type;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Character) {
      final characterRect = other.toRect();
      final blockRect = toRect();

      // Xác định hướng va chạm (ngang hay dọc)
      final overlapX = (characterRect.left < blockRect.left)
          ? characterRect.right - blockRect.left
          : blockRect.right - characterRect.left;

      final overlapY = (characterRect.top < blockRect.top)
          ? characterRect.bottom - blockRect.top
          : blockRect.bottom - characterRect.top;

      final isHorizontalCollision = overlapX < overlapY;
      final fromLeft = characterRect.center.dx < blockRect.center.dx;
      final fromTop = characterRect.center.dy < blockRect.center.dy;

      // Xử lý EnvironmentBlock (chặn toàn bộ các hướng)
      if (type == EnvironmentType.block) {
        if (isHorizontalCollision) {
          other.x = fromLeft
              ? x - other.width // va chạm bên trái
              : x + width; // va chạm bên phải
          other.velocity.x = 0;
        } else {
          other.y = fromTop
              ? y - other.height // va chạm từ trên
              : y + height; // va chạm từ dưới
          other.velocity.y = 0;

          if (fromTop) {
            other.isOnGround = true;
          }
        }
      }

      // Xử lý EnvironmentPlatform (chặn 1 chiều từ trên xuống)
      if (type == EnvironmentType.platform) {
        final isFalling = other.velocity.y > 0;
        final isOnTopOfPlatform = characterRect.bottom <= blockRect.top + 10;

        if (!isHorizontalCollision &&
            fromTop &&
            isFalling &&
            isOnTopOfPlatform) {
          other.y = y - other.width;
          other.velocity.y = 0;
          other.isOnGround = true;
        }
      }
    }

    super.onCollision(intersectionPoints, other);
  }
}
