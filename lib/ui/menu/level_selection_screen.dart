
import 'package:flutter/material.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'package:pixel_adventure/ui/menu/widgets/animated_background.dart';

import 'package:pixel_adventure/ui/menu/widgets/menu_button.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_type.dart';

class LevelSelectionScreen extends StatelessWidget {
  final PixelAdventure game;

  const LevelSelectionScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return MenuBackground(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Level',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(
                  game.levelNumbers.length,
                  (index) => LevelButton(
                    level: index + 1,
                    isLocked: !game.isLevelUnlocked(index + 1),
                    isCurrent: index == game.currentLevel - 1,
                    isBoss: (index + 1) % 10 == 0,
                    isCompleted: game.isLevelCompleted(index + 1),
                    onTap: () {
                      if (index < game.levelNumbers.length) {
                        game.currentLevel = index + 1;
                        game.startGame();
                        game.overlays.remove('LevelSelectionScreen');
                        game.overlays.remove('MenuScreen');
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              MenuButton(
                menuType: MenuType.back,
                onPressed: () {
                  game.overlays.remove('LevelSelectionScreen');
                  game.overlays.add('MenuScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelButton extends StatefulWidget {
  final int level;
  final bool isLocked;
  final bool isCurrent;
  final bool isBoss;
  final bool isCompleted;
  final VoidCallback onTap;

  const LevelButton({
    super.key,
    required this.level,
    required this.isLocked,
    required this.isCurrent,
    required this.isBoss,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  State<LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.9,
      upperBound: 1.1,
      value: 1.0,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    _controller.animateTo(0.95, duration: const Duration(milliseconds: 80));
  }

  void _onTapUp(_) {
    _controller.animateTo(1.0, duration: const Duration(milliseconds: 80));
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isCurrent
        ? Colors.yellowAccent
        : widget.isCompleted
            ? Colors.greenAccent
            : Colors.white.withValues(alpha: 0.2);
    final boxShadow = widget.isCurrent
        ? <BoxShadow>[
            BoxShadow(
              color: Colors.yellowAccent.withValues(alpha: 0.7),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ]
        : widget.isCompleted
            ? <BoxShadow>[
                BoxShadow(
                  color: Colors.greenAccent.withValues(alpha: 0.7),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : <BoxShadow>[];
    return GestureDetector(
      onTap: widget.isLocked ? null : widget.onTap,
      onTapDown: widget.isLocked ? null : _onTapDown,
      onTapUp: widget.isLocked ? null : _onTapUp,
      onTapCancel: widget.isLocked ? null : () => _controller.animateTo(1.0),
      onLongPress: () {
        final snackBar = SnackBar(
          content: Text(widget.isBoss
              ? 'Boss Level! Prepare for a challenge! 😈'
              : widget.isLocked
                  ? 'This level is locked! Beat previous levels to unlock.'
                  : widget.isCompleted
                      ? 'Level ${widget.level}: Completed! 🏆'
                      : 'Level ${widget.level}: Good luck!'),
          duration: const Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 80),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: widget.isLocked
                ? Colors.grey.withValues(alpha: 0.3)
                : widget.isCompleted
                    ? Colors.greenAccent.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            boxShadow: boxShadow,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isBoss)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Text('👾', style: TextStyle(fontSize: 18)),
                ),
              if (widget.isCompleted)
                const Positioned(
                  bottom: 6,
                  right: 6,
                  child: Text('🏆', style: TextStyle(fontSize: 18)),
                ),
              Center(
                child: widget.isLocked
                    ? const Icon(Icons.lock, color: Colors.white54, size: 28)
                    : Text(
                        widget.level.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          color: widget.isCompleted
                              ? Colors.greenAccent
                              : Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
