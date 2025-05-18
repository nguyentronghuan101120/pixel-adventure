import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/environments/environment_block.dart';
import 'package:pixel_adventure/components/environments/environment_platform.dart';
import 'package:pixel_adventure/configs/character_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Character extends SpriteAnimationGroupComponent
    with HasGameReference<PixelAdventure>, KeyboardHandler, CollisionCallbacks {
  Character({
    required CharacterConfig characterConfig,
  }) : _characterConfig = characterConfig;
  final CharacterConfig _characterConfig;
  Vector2 velocity = Vector2.zero();
  CharacterDirection _direction = CharacterDirection.none;
  final double _gravity = 9.8;
  final double _terminalVelocity = 300;
  bool _isOnGround = false;
  bool _hasJumped = false;
  late Vector2 _initialPosition;
  bool _gotHit = false;

  @override
  void onLoad() {
    super.onLoad();
    _animationLoad();
    add(
      RectangleHitbox(
        size: Vector2(24, 26),
        position: Vector2(4, size.y - 26),
        isSolid: true,
      ),
    );
    _initialPosition = position.clone();
  }

  void _animationLoad() {
    animations = {
      for (final state in CharacterState.values) state: _spriteAnimation(state),
    };
    current = CharacterState.idle;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_gotHit) {
      _updatePlayerPosition(dt);
      _applyGravity(dt);
      _updateAnimationState();
    }
  }

  void _updatePlayerPosition(double dt) {
    if (_hasJumped) {
      _jump(dt);
    }

    if (!_isOnGround && velocity.y > 0) {
      current = CharacterState.fall;
    }

    position += velocity * dt;
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y =
        velocity.y.clamp(-_characterConfig.jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _updateAnimationState() {
    if (!_isOnGround) {
      if (velocity.y < 0) {
        current = CharacterState.jump;
      } else if (velocity.y > 0) {
        current = CharacterState.fall;
      }
    } else if (velocity.x > 0) {
      current = CharacterState.run;
      _direction = CharacterDirection.right;
    } else if (velocity.x < 0) {
      current = CharacterState.run;
      _direction = CharacterDirection.left;
    } else {
      current = CharacterState.idle;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      _moveLeft();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      _moveRight();
    } else {
      _stop();
    }

    _hasJumped =
        event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space;

    return false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    final characterRect = toRect();
    final blockRect = other.toRect();

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
    if (other is EnvironmentBlock) {
      if (isHorizontalCollision) {
        x = fromLeft
            ? other.x - width // va chạm bên trái
            : other.x + other.width; // va chạm bên phải
        velocity.x = 0;
      } else {
        y = fromTop
            ? other.y - height // va chạm từ trên
            : other.y + other.height; // va chạm từ dưới
        velocity.y = 0;

        if (fromTop) {
          _isOnGround = true;
        }
      }
    }

    // Xử lý EnvironmentPlatform (chặn 1 chiều từ trên xuống)
    if (other is EnvironmentPlatform) {
      final isFalling = velocity.y > 0;
      final isOnTopOfPlatform = characterRect.bottom <= blockRect.top + 10;

      if (!isHorizontalCollision && fromTop && isFalling && isOnTopOfPlatform) {
        y = other.y - width;
        velocity.y = 0;
        _isOnGround = true;
      }
    }
  }

  void joystickMove(JoystickDirection direction) {
    switch (direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        _moveLeft();
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        _moveRight();
        break;
      // case JoystickDirection.up:
      //   _jump();
      //   break;
      default:
        _stop();
    }
  }

  SpriteAnimation _spriteAnimation(CharacterState state) {
    final bool isSpecialAnimation = state == CharacterState.appearing ||
        state == CharacterState.desapearing;
    String fromCachePath =
        "Main Characters/${_characterConfig.name.value}/${state.value} (32x32).png";
    if (isSpecialAnimation) {
      fromCachePath = "Main Characters/${state.value} (96x96).png";
    }

    return SpriteAnimation.fromFrameData(
      game.images.fromCache(
        fromCachePath,
      ),
      SpriteAnimationData.sequenced(
          amount: state.animationSequenceAmount,
          stepTime: _characterConfig.stepTime,
          textureSize: Vector2.all(isSpecialAnimation ? 96 : 32),
          loop: !isSpecialAnimation),
    );
  }

  void _moveLeft() {
    _direction = CharacterDirection.left;
    velocity.x = -_characterConfig.speed;
  }

  void _moveRight() {
    velocity.x = _characterConfig.speed;
    current = CharacterState.run;
  }

  void _jump(double dt) {
    if (!_isOnGround) return;

    _isOnGround = false;

    velocity.y = -_characterConfig.jumpForce;
  }

  void _stop() {
    velocity.x = 0;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    if (_direction == CharacterDirection.left) {
      canvas.translate(size.x, 0);
      canvas.scale(-1, 1);
    }
    super.render(canvas);
    canvas.restore();
  }

  void respawn() async {
    if (_gotHit) return; // Prevent overlapping respawns
    position = position - Vector2.all(32);
    _gotHit = true;

    current = CharacterState.desapearing;

    await Future.delayed(
      Duration(
        milliseconds: CharacterState.desapearing.animationSequenceAmount * 50,
      ),
    );

    // Reset position and state
    position = _initialPosition - Vector2.all(32);
    velocity = Vector2.zero();
    _direction = CharacterDirection.none;
    _isOnGround = false;
    _hasJumped = false;

    current = CharacterState.appearing;
    scale.x = 1;
    await Future.delayed(
      Duration(
        milliseconds: CharacterState.appearing.animationSequenceAmount * 50,
      ),
    );

    position = _initialPosition;

    _updateAnimationState();
    _gotHit = false;
  }
}
