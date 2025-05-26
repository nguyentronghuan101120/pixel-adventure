import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/character_config.dart';
import 'package:pixel_adventure/configs/game_configs.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  int levelNumber = 1;

  final Character character = Character(
    characterConfig: CharacterConfig(
      name: CharacterName.virtualGuy,
    ),
  );

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
      player: character,
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
  }

  // double timeElapsed = 0;
  // static const timePerFrame = 1 / 15;
  // @override
  // void updateTree(double dt) {
  //   timeElapsed += dt;
  //   if (timeElapsed > timePerFrame) {
  //     timeElapsed -= timePerFrame;
  //     super.updateTree(timePerFrame);
  //   }
  // }
}
