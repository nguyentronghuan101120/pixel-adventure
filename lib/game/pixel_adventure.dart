import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/joystick.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/character_config.dart';
import 'package:pixel_adventure/configs/game_configs.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  int levelNumber = 0;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  void onLoad() async {
    super.onLoad();

    await images.loadAllImages();

    loadOrNextLevel();

    // debugMode = true;
  }

  void loadOrNextLevel() {
    removeWhere((component) => component is Level);

    levelNumber++;
    final level = Level(
      player: Character(
        characterConfig: CharacterConfig(
          name: CharacterName.virtualGuy,
        ),
      ),
      levelNumber: levelNumber,
    );

    final CameraComponent camera = CameraComponent.withFixedResolution(
      world: level,
      width: GameConfigs.screenWidth,
      height: GameConfigs.screenHeight,
    );

    camera.viewfinder.anchor = Anchor.topLeft;
    addAll([
      camera,
      level,
    ]);
    if (Platform.isIOS || Platform.isAndroid) {
      camera.viewport.add(GameJoystick(player: level.player));
    }
  }

  // double timeElapsed = 0;
  // static const timePerFrame = 1 / 60;
  // @override
  // void updateTree(double dt) {
  //   timeElapsed += dt;
  //   if (timeElapsed > timePerFrame) {
  //     timeElapsed -= timePerFrame;
  //     super.updateTree(timePerFrame);
  //   }
  // }
}
