import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/ui/hud/joystick.dart';
import 'package:pixel_adventure/ui/hud/jump_button.dart';
import 'package:pixel_adventure/ui/hud/back_button.dart';
import 'package:pixel_adventure/configs/game_overlay_config.dart';
import 'package:pixel_adventure/ui/menu/game_complete_screen.dart';
import 'package:pixel_adventure/ui/menu/level_selection_screen.dart';
import 'package:pixel_adventure/ui/menu/menu_screen.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  await windowManager.ensureInitialized();

  // Set the minimum window size
  await windowManager.setMinimumSize(
      const Size(1280, 720)); // Set your desired min width and height

  // Optional: Set a default window size
  await windowManager.setSize(const Size(1280, 720));

  final PixelAdventure game = PixelAdventure();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: GameWidget(
        game: kDebugMode ? PixelAdventure() : game,
        overlayBuilderMap: {
          GameOverlay.menu.name: (context, PixelAdventure game) =>
              MenuScreen(game: game),
          GameOverlay.levelSelection.name: (context, PixelAdventure game) =>
              LevelSelectionScreen(game: game),
          GameOverlay.gameComplete.name: (context, PixelAdventure game) =>
              GameCompleteScreen(game: game, score: 100, stars: 3),
          GameOverlay.backButton.name: (context, PixelAdventure game) =>
              GameBackButton(game: game),
          if (!kIsWeb)
            GameOverlay.jumpButton.name: (context, PixelAdventure game) =>
                JumpButton(
                  onJump: () {
                    game.character.jump();
                  },
                ),
          if (!kIsWeb)
            GameOverlay.joystick.name: (context, PixelAdventure game) =>
                Joystick(onDirectionChanged: (direction) {
                  game.character.joystickMove(direction);
                }),
        },
        initialActiveOverlays: [GameOverlay.menu.name],
      ),
    ),
  ));
}
