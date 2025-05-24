import 'package:flutter/material.dart';

class JumpButton extends StatelessWidget {
  final VoidCallback onJump;
  const JumpButton({super.key, required this.onJump});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 64, bottom: 64),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: onJump,
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              border: Border.all(color: Colors.brown, width: 6),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: 0.5),
                  offset: Offset(6, 8),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'JUMP',
                style: TextStyle(
                  fontFamily:
                      'PressStart2P', // Use a pixel/retro font if available
                  fontSize: 24,
                  color: Colors.brown[900],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
