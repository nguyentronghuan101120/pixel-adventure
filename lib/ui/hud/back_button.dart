import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'package:pixel_adventure/gen/fonts.gen.dart';

class GameBackButton extends StatelessWidget {
  final PixelAdventure game;

  const GameBackButton({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black.withValues(alpha: 0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              title: Text(
                'EXIT LEVEL?',
                style: TextStyle(
                  fontFamily: FontFamily.pixelMania,
                  color: Colors.white,
                  fontSize: 24,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              content: Text(
                'Are you sure you want to exit this level?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontFamily: FontFamily.pixelMania,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    game.exitLevel();
                  },
                  child: Text(
                    'EXIT',
                    style: TextStyle(
                      fontFamily: FontFamily.pixelMania,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'BACK',
                style: TextStyle(
                  fontFamily: FontFamily.pixelMania,
                  color: Colors.white,
                  fontSize: 16,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
