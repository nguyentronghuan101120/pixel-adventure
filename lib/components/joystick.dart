import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/character.dart';

class GameJoystick extends JoystickComponent {
  GameJoystick({required this.player})
      : super(
          knob: _buildKnob(),
          background: _buildBackground(),
          margin: const EdgeInsets.only(left: 40, bottom: 40),
        );

  final Character player;
  JoystickDirection? _lastDirection;

  @override
  void update(double dt) {
    super.update(dt);
    if (_lastDirection != direction) {
      player.joystickMove(direction);
      _lastDirection = direction;
    }
  }

  static CircleComponent _buildKnob() => CircleComponent(
        radius: 32,
        paint: Paint()..color = Colors.white,
      );

  static CircleComponent _buildBackground() => CircleComponent(
        radius: 64,
        paint: Paint()..color = Colors.black54,
      );
}
