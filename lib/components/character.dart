import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/configs/character_config.dart';
import 'package:pixel_adventure/configs/sound_config.dart';
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
  bool isOnGround = false;
  bool _hasJumped = false;
  late Vector2 _initialPosition;
  bool _gotHit = false;
  bool _hasCompleted = false;

  final double _fixedDeltatime = 1 / 60;

  // CharacterState _previousState = CharacterState.idle;

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
    // debugMode = true;
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

    // if (game.soundConfig.hasSound && current != _previousState) {
    //   switch (current) {
    //     case CharacterState.jump:
    //       FlameAudio.play(SoundName.jump.value,
    //           volume: game.soundConfig.volume);
    //       break;
    //     case CharacterState.hit:
    //       FlameAudio.play(SoundName.hit.value, volume: game.soundConfig.volume);
    //       break;
    //     case CharacterState.complete:
    //       FlameAudio.play(SoundName.complete.value,
    //           volume: game.soundConfig.volume);
    //       break;
    //     case CharacterState.collect:
    //       FlameAudio.play(SoundName.collect.value,
    //           volume: game.soundConfig.volume);
    //       break;
    //   }
    //   _previousState = current;
    // }

    if (!_gotHit && !_hasCompleted) {
      _updatePlayerPosition(_fixedDeltatime);
      _applyGravity(_fixedDeltatime);
      _updateAnimationState();
    }
  }

  void _updatePlayerPosition(double dt) {
    if (_hasJumped) {
      jump();
    }

    if (!isOnGround && velocity.y > 0) {
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
    if (!isOnGround) {
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
          loop: !isSpecialAnimation && state != CharacterState.hit),
    );
  }

  void _moveLeft() {
    if (_gotHit) return;
    _direction = CharacterDirection.left;
    velocity.x = -_characterConfig.speed;
  }

  void _moveRight() {
    if (_gotHit) return;
    velocity.x = _characterConfig.speed;
    current = CharacterState.run;
  }

  void jump() {
    if (!isOnGround || _gotHit) return;
    FlameAudio.play(SoundName.jump.value, volume: game.soundConfig.volume);
    isOnGround = false;

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
    // If got hit, do nothing
    if (_gotHit) return;

    SoundName.hit.play(game.soundConfig);

    // Set the character to the hit state
    _gotHit = true;

    // Start animation
    current = CharacterState.hit;

    // Wait for the animation to complete
    await animationTicker?.completed;

    // Move character to the top of the response animation because it's size is 64
    position = position - Vector2.all(32);

    current = CharacterState.desapearing;

    await animationTicker?.completed;

    // Reset position and state
    position = _initialPosition - Vector2.all(32);
    current = CharacterState.appearing;

    await animationTicker?.completed;

    position = _initialPosition;

    // Show the character again
    current = CharacterState.idle;

    // Reset direction and velocity
    _direction = CharacterDirection.right;
    // If user jump and got hit, the character will jump when respawn, so we need to reset the velocity
    velocity = Vector2.zero();

    // Reset hit state
    _gotHit = false;
  }

  void complete() async {
    if (_hasCompleted) return;

    SoundName.complete.play(game.soundConfig);
    position = position - Vector2.all(32);

    _hasCompleted = true;

    current = CharacterState.desapearing;
    await Future.delayed(
      Duration(
        milliseconds: CharacterState.desapearing.animationSequenceAmount * 50,
      ),
    );

    removeFromParent();

    await Future.delayed(
      Duration(
        seconds: 2,
      ),
    );

    game.loadOrNextLevel();

    _hasCompleted = false;

    _direction = CharacterDirection.right;
  }
}
