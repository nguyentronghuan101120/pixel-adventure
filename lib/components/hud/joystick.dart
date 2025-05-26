import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Joystick extends StatefulWidget {
  final void Function(JoystickDirection direction) onDirectionChanged;

  const Joystick({super.key, required this.onDirectionChanged});

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _dragPosition = Offset.zero;
  final double _radius = 60.0;
  JoystickDirection _lastDirection = JoystickDirection.idle;

  void _updatePosition(Offset localPosition) {
    final center = Offset(_radius, _radius);
    final offset = localPosition - center;

    final distance = offset.distance;
    final clampedDistance = min(distance, _radius);

    final angle = atan2(offset.dy, offset.dx);
    final clampedOffset = Offset(
      cos(angle) * clampedDistance,
      sin(angle) * clampedDistance,
    );

    setState(() {
      _dragPosition = clampedOffset;
    });

    final normalizedOffset = clampedOffset / _radius;
    final direction = _calculateDirection(normalizedOffset);

    if (direction != _lastDirection) {
      _lastDirection = direction;
      widget.onDirectionChanged(direction);
    }
  }

  void _resetPosition() {
    setState(() {
      _dragPosition = Offset.zero;
      _lastDirection = JoystickDirection.idle;
    });
    widget.onDirectionChanged(JoystickDirection.idle);
  }

  JoystickDirection _calculateDirection(Offset offset) {
    const deadZone = 0.2;
    if (offset.distance < deadZone) return JoystickDirection.idle;

    final angle = atan2(offset.dy, offset.dx);
    const pi8 = pi / 8;

    if (angle >= -pi8 && angle < pi8) return JoystickDirection.right;
    if (angle >= pi8 && angle < 3 * pi8) return JoystickDirection.downRight;
    if (angle >= 3 * pi8 && angle < 5 * pi8) return JoystickDirection.down;
    if (angle >= 5 * pi8 && angle < 7 * pi8) return JoystickDirection.downLeft;
    if (angle >= 7 * pi8 || angle < -7 * pi8) return JoystickDirection.left;
    if (angle >= -7 * pi8 && angle < -5 * pi8) return JoystickDirection.upLeft;
    if (angle >= -5 * pi8 && angle < -3 * pi8) return JoystickDirection.up;
    if (angle >= -3 * pi8 && angle < -pi8) return JoystickDirection.upRight;

    return JoystickDirection.idle;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, bottom: 64),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
          onPanStart: (details) => _updatePosition(details.localPosition),
          onPanUpdate: (details) => _updatePosition(details.localPosition),
          onPanEnd: (_) => _resetPosition(),
          child: Container(
            width: _radius * 2,
            height: _radius * 2,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.yellow[200]!.withValues(alpha: 0.01),
                  Colors.brown[700]!.withValues(alpha: 0.01),
                ],
                center: const Alignment(-0.3, 0.3),
                radius: 0.95,
              ),
              border: Border.all(color: Colors.brown, width: 6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: .5),
                  offset: const Offset(6, 8),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Transform.translate(
                offset: _dragPosition,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    border: Border.all(color: Colors.brown, width: 4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withValues(alpha: .3),
                        offset: const Offset(2, 3),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '●',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 28,
                        color: Colors.brown[900],
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(1, 1),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
