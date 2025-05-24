import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/hud/joystick.dart';
import 'package:pixel_adventure/components/hud/jump_button.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final PixelAdventure game = PixelAdventure();

  runApp(MaterialApp(
    home: Scaffold(
      body: GameWidget(
        game: kDebugMode ? PixelAdventure() : game,
        overlayBuilderMap: Platform.isIOS || Platform.isAndroid
            ? {
                'JumpButton': (context, PixelAdventure game) => JumpButton(
                      onJump: () {
                        game.character.jump();
                      },
                    ),
                'Joystick': (context, PixelAdventure game) =>
                    Joystick(onDirectionChanged: (direction) {
                      game.character.joystickMove(direction);
                    }),
              }
            : null,
        initialActiveOverlays: Platform.isIOS || Platform.isAndroid
            ? const ['JumpButton', 'Joystick']
            : null,
      ),
    ),
  ));
}
