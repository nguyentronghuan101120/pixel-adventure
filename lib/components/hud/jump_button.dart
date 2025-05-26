import 'package:flutter/material.dart';
import 'package:pixel_adventure/gen/assets.gen.dart';

class JumpButton extends StatefulWidget {
  final VoidCallback onJump;
  const JumpButton({super.key, required this.onJump});

  @override
  State<JumpButton> createState() => _JumpButtonState();
}

class _JumpButtonState extends State<JumpButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 64, bottom: 64),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              isPressed = true;
            });
            widget.onJump();
          },
          onTapUp: (_) {
            setState(() {
              isPressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              isPressed = false;
            });
          },
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: isPressed
                  ? Colors.yellow[400]!.withValues(alpha: 0.3)
                  : Colors.yellow[200]!.withValues(alpha: 0.01),
              border: Border.all(color: Colors.brown, width: 6),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: 0.1),
                  offset: Offset(isPressed ? 2 : 6, isPressed ? 4 : 8),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: RotatedBox(
              quarterTurns: -1,
              child: Assets.images.hud.jumpButton.image(),
            ),
          ),
        ),
      ),
    );
  }
}
