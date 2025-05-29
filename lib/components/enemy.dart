import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/components/environment.dart';
import 'package:pixel_adventure/configs/enemy_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'dart:math' as math;

class Enemy extends SpriteAnimationGroupComponent
    with HasGameReference<PixelAdventure>, CollisionCallbacks {
  Enemy({
    required Vector2 position,
    required Vector2 size,
    required this.type,
    required this.moveRangeTiles,
  }) : super(position: position, size: size);

  final EnemyType type;
  final int moveRangeTiles;
  final double moveSpeed = math.Random().nextDouble() * 0.5 + 1;
  final double _fixedDt = 1 / 60;
  final double _speed = 60;
  bool _isMovingRight = false;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    _loadAnimation();

    add(RectangleHitbox());
    // debugMode = true;
    return super.onLoad();
  }

  void _loadAnimation() {
    animations = {
      for (final state in EnemyState.values) state: _spriteAnimation(state),
    };
    current = EnemyState.idle;
  }

  SpriteAnimation _spriteAnimation(EnemyState state) {
    final animationConfig = type.animationConfig;
    final frames = animationConfig.animations[state] ?? [];
    if (frames.isEmpty) {
      debugPrint(
          'No animation frames found for state $state, using default animation');
      // Return a default animation with a single frame
      return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/${type.value}/Idle (32x34).png'),
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.05,
          textureSize: Vector2(32, 34),
        ),
      );
    }
    final frame = frames.first;

    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/${type.value}/${frame.imageName}.png'),
      SpriteAnimationData.sequenced(
          amount: frame.animationSequenceAmount,
          stepTime: 0.05, // Default step time
          textureSize: frame.textureSize,
          loop: frame.canLoop),
    );
  }

  @override
  void update(double dt) {
    if (current != EnemyState.hit) {
      _move();
      _moveToCharacter();
    }
    super.update(dt);
  }

  void _move() {
    if (_isMovingRight) {
      _moveRight();
    } else {
      _moveLeft();
    }

    if (x == 450) {
      _changeDirectionMove();
    }
  }

  void _moveToCharacter() {
    if ((game.character.position.y - position.y).abs() < 0.2) {
      if (position.x < game.character.x) {
        _moveRight();
      } else {
        _moveLeft();
      }
    }
  }

  void _changeDirectionMove() {
    _isMovingRight = !_isMovingRight;
  }

  void _moveRight() {
    position.x += _speed * _fixedDt;
    _isMovingRight = true;
    current = EnemyState.run;
  }

  void _moveLeft() {
    position.x -= _speed * _fixedDt;
    _isMovingRight = false;
    current = EnemyState.run;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Character) {
      await _characterCollision(other);
    }

    if (other is EnvironmentComponent) {
      _changeDirectionMove();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  Future<void> _characterCollision(Character other) async {
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
    final fromTop = characterRect.center.dy < blockRect.center.dy;

    if (isHorizontalCollision) {
      other.respawn();
    } else if (fromTop) {
      other.isOnGround = true;
      other.jump();
      current = EnemyState.hit;
      await animationTicker?.completed;
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    if (_isMovingRight) {
      canvas.translate(size.x, 0);
      canvas.scale(-1, 1);
    }
    super.render(canvas);
    canvas.restore();
  }
}
