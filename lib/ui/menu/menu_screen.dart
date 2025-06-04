import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'package:pixel_adventure/ui/menu/widgets/animated_background.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_button.dart';
import 'package:pixel_adventure/gen/fonts.gen.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_type.dart';

class MenuScreen extends StatefulWidget {
  final PixelAdventure game;

  const MenuScreen({super.key, required this.game});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSoundOn = true;

  @override
  void initState() {
    super.initState();
    isSoundOn = widget.game.soundConfig.hasSound;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuBackground(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'PIXEL ADVENTURE',
                      style: const TextStyle(
                        fontFamily: FontFamily.pixelMania,
                        fontSize: 48, // Larger for emphasis
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MenuButton(
                          onPressed: () {
                            widget.game.startGame();
                            widget.game.overlays.remove('MenuScreen');
                          },
                          menuType: MenuType.start,
                        ),
                        const SizedBox(height: 16),
                        MenuButton(
                          menuType: MenuType.chooseLevel,
                          onPressed: () {
                            widget.game.overlays.add('LevelSelectionScreen');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSoundOn = !isSoundOn;
                widget.game.triggerSound(isSoundOn);
              });
            },
            child: isSoundOn
                ? Icon(
                    Icons.volume_up,
                    size: 48,
                  )
                : Icon(
                    Icons.volume_off,
                    size: 48,
                  ),
          ),
        ),
      ],
    );
  }
}
