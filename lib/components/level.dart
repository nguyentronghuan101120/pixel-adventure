import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/background_tile.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/components/checkpoint.dart';
import 'package:pixel_adventure/components/environment.dart';
import 'package:pixel_adventure/components/fruit.dart';
import 'package:pixel_adventure/components/traps/hole.dart';
import 'package:pixel_adventure/components/traps/saw.dart';
import 'package:pixel_adventure/configs/background_config.dart';
import 'package:pixel_adventure/configs/enviroment_config.dart';
import 'package:pixel_adventure/configs/fruit_config.dart';
import 'package:pixel_adventure/configs/item_config.dart';
import 'package:pixel_adventure/configs/level_configs.dart';
import 'package:pixel_adventure/configs/trap_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class Level extends World with HasGameReference<PixelAdventure> {
  late TiledComponent level;

  Level({
    required this.player,
    required this.levelNumber,
  });

  final Character player;
  final int levelNumber;

  @override
  void onLoad() async {
    level = await TiledComponent.load(
      'level$levelNumber.tmx',
      Vector2.all(16),
    );
    add(level);
    _createBackground();

    final layers = level.tileMap.map.layers
        .where((layer) => layer.type == LayerType.objectGroup);

    for (final layer in layers) {
      final objectGroup = level.tileMap.getLayer<ObjectGroup>(layer.name);
      final classNameOfLayer = layer.class_;

      if (objectGroup == null) {
        throw Exception("No object group with name: ${layer.name}");
      }

      if (classNameOfLayer == null) {
        throw Exception("No class name of layer ${layer.class_}");
      }

      switch (LevelEntities.values.byName(classNameOfLayer)) {
        case LevelEntities.env:
          _loadEnv(objectGroup);
          break;
        case LevelEntities.spawnpoint:
          _loadSpawnpoint(objectGroup);
          break;
        case LevelEntities.trap:
          _loadTrap(objectGroup);
          break;
        case LevelEntities.item:
          _loadItem(objectGroup);
          break;
      }
    }
  }

  void _loadSpawnpoint(ObjectGroup objectGroup) {
    final object = objectGroup.objects.first;
    player.position = object.position;
    add(player);
  }

  void _loadItem(ObjectGroup objectGroup) {
    for (final object in objectGroup.objects) {
      final ItemType itemType = ItemType.values.byName(object.class_);

      switch (itemType) {
        case ItemType.fruit:
          final fruit = Fruit(
            position: object.position,
            size: object.size,
            fruit: FruitName.values.byName(object.name),
          );

          add(fruit);

          break;
        case ItemType.checkpoint:
          final checkpoint = Checkpoint(
            position: object.position,
            size: object.size,
          );
          add(checkpoint);
          break;
      }
    }
  }

  void _loadEnv(ObjectGroup objectGroup) {
    for (final object in objectGroup.objects) {
      final EnvironmentType type = EnvironmentType.values.byName(object.name);

      final platform = EnvironmentComponent(
        position: object.position,
        size: object.size,
        type: type,
      );
      add(platform);
    }
  }

  void _createBackground() {
    final double tileSize = 64;

    final numberOfTilesX = (game.size.x / tileSize).ceil() + 2;
    final numberOfTilesY = (game.size.y / tileSize).ceil() + 2;
    final random = Random();

    final background = level.tileMap.getLayer('background');
    if (background != null) {
      final backgroundColor = background.properties.getValue('backgroundColor');

      if (backgroundColor == null) return;

      // Generate a single random direction vector for all tiles
      final direction = Vector2(
        (random.nextBool() ? 1 : -1) * (random.nextDouble() * 20),
        (random.nextBool() ? 1 : -1) * (random.nextDouble() * 20),
      );

      for (int x = 0; x < numberOfTilesX; x++) {
        for (int y = 0; y < numberOfTilesY; y++) {
          final backgroundTile = BackgroundTile(
            color: BackgroundColor.values.byName(backgroundColor),
            position: Vector2(x * tileSize.toDouble(), y * tileSize.toDouble()),
            velocity: direction,
          );

          add(backgroundTile);
        }
      }
    }
  }

  void _loadTrap(ObjectGroup objectGroup) {
    for (final object in objectGroup.objects) {
      final TrapType type = TrapType.values.byName(object.name);
      switch (type) {
        case TrapType.hole:
          final hole = Hole(
            position: object.position,
            size: object.size,
          );
          add(hole);
          break;
        case TrapType.saw:
          final moveRangeTiles = object.properties.getValue("moveRangeTiles");
          final isVerticalMove = object.properties.getValue("isVerticalMove");
          final trap = Saw(
            position: object.position,
            size: object.size,
            type: TrapType.values.byName(object.name),
            moveRangeTiles: moveRangeTiles,
            isVerticalMove: isVerticalMove,
          );
          add(trap);
          break;
        case TrapType.arrow:
        case TrapType.blocks:
        case TrapType.fallingPlatforms:
        case TrapType.fan:
        case TrapType.fire:
        case TrapType.platforms:
        case TrapType.rockHead:
        case TrapType.sandMudIce:
        case TrapType.spikeHead:
        case TrapType.spikeBall:
        case TrapType.spikes:
        case TrapType.trampoline:
          break;
      }
    }
  }
}
