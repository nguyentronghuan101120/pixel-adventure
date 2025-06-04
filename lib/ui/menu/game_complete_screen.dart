import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'package:pixel_adventure/gen/fonts.gen.dart';
import 'package:pixel_adventure/ui/menu/widgets/animated_background.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_button.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_type.dart';

class GameCompleteScreen extends StatefulWidget {
  final PixelAdventure game;
  final int score;
  final int stars;

  const GameCompleteScreen({
    super.key,
    required this.game,
    required this.score,
    required this.stars,
  });

  @override
  State<GameCompleteScreen> createState() => _GameCompleteScreenState();
}

class _GameCompleteScreenState extends State<GameCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuBackground(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(32),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.yellowAccent.withValues(alpha: 0.5),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellowAccent.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '🎉 LEVEL COMPLETE! 🎉',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: FontFamily.pixelMania,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  index < widget.stars
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellowAccent,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'SCORE: ${widget.score}',
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontFamily.pixelMania,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MenuButton(
                                menuType: MenuType.restart,
                                onPressed: () {
                                  widget.game.restartGame();
                                  widget.game.overlays
                                      .remove('GameCompleteScreen');
                                },
                              ),
                              if (widget.game.currentLevel <
                                  widget.game.levelNumbers.length)
                                MenuButton(
                                  menuType: MenuType.next,
                                  onPressed: () {
                                    widget.game.nextLevel();
                                    widget.game.overlays
                                        .remove('GameCompleteScreen');
                                },
                              ),
                              const SizedBox(height: 16),
                              MenuButton(
                                menuType: MenuType.menu,
                                onPressed: () {
                                  widget.game.overlays
                                      .remove('GameCompleteScreen');
                                  widget.game.overlays.add('MenuScreen');
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
            );
          },
        ),
      ),
    );
  }
}
