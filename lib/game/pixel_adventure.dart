import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/configs/character_config.dart';
import 'package:pixel_adventure/configs/game_configs.dart';
import 'package:pixel_adventure/components/level.dart';
import 'package:pixel_adventure/configs/game_overlay_config.dart';
import 'package:pixel_adventure/configs/sound_config.dart';
import 'package:pixel_adventure/services/level_progress_service.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  bool isGameStarted = false;

  final List<int> levelNumbers = List.generate(3, (index) => index + 1);

  int currentLevel = 1;
  late LevelProgressService _levelProgressService;

  SoundConfig soundConfig = SoundConfig();

  final Character character = Character(
    characterConfig: CharacterConfig(
      name: CharacterName.virtualGuy,
    ),
  );

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await images.loadAllImages();
    _levelProgressService = await LevelProgressService.init();
    currentLevel = _levelProgressService.getCurrentLevel();

    // Initialize sound based on saved preference
    soundConfig =
        soundConfig.copyWith(hasSound: _levelProgressService.isSoundEnabled());
    if (soundConfig.hasSound) {
      FlameAudio.bgm
          .play(SoundName.background.value, volume: soundConfig.volume);
    }
  }

  void startGame() {
    FlameAudio.bgm.stop();
    isGameStarted = true;
    loadLevel();
  }

  void restartGame() {
    loadLevel();
  }

  void nextLevel() async {
    // Mark current level as completed before moving to next level
    await _levelProgressService.markLevelAsCompleted(currentLevel);
    currentLevel++;
    await _levelProgressService.setCurrentLevel(currentLevel);
    loadLevel();
  }

  void loadLevel() {
    removeWhere((component) => component is Level);

    final level = Level(
      player: character,
      levelNumber: currentLevel,
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

  void triggerSound(bool hasSound) async {
    soundConfig = soundConfig.copyWith(hasSound: hasSound);
    await _levelProgressService.setSoundEnabled(hasSound);
    if (hasSound) {
      FlameAudio.bgm
          .play(SoundName.background.value, volume: soundConfig.volume);
    } else {
      FlameAudio.bgm.stop();
    }
  }

  bool isLevelUnlocked(int level) {
    return _levelProgressService.isLevelUnlocked(level);
  }

  List<int> getUnlockedLevels() {
    return _levelProgressService.getUnlockedLevels();
  }

  bool isLevelCompleted(int level) {
    return _levelProgressService.isLevelCompleted(level);
  }

  List<int> getCompletedLevels() {
    return _levelProgressService.getCompletedLevels();
  }

  Future<void> markLevelAsCompleted(int level) async {
    await _levelProgressService.markLevelAsCompleted(level);
  }

  void exitLevel() {
    overlays.remove(GameOverlay.backButton.name);
    overlays.add(GameOverlay.levelSelection.name);
    removeWhere((component) => component is Level);
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
