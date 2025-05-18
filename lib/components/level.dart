import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/background_tile.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/components/environments/environment_block.dart';
import 'package:pixel_adventure/components/environments/environment_platform.dart';
import 'package:pixel_adventure/components/fruit.dart';
import 'package:pixel_adventure/components/traps/saw.dart';
import 'package:pixel_adventure/configs/background_config.dart';
import 'package:pixel_adventure/configs/enviroment_config.dart';
import 'package:pixel_adventure/configs/fruit_config.dart';
import 'package:pixel_adventure/configs/spawnpoint_config.dart';
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

    _loadSpawnpoints();
    _loadCollisions();
  }

  void _loadSpawnpoints() {
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('spawnpoints');

    if (spawnpointsLayer == null) {
      throw Exception('Spawnpoints layer not found');
    }

    for (final spawnpoint in spawnpointsLayer.objects) {
      final SpawnpointType type =
          SpawnpointType.values.byName(spawnpoint.class_);

      switch (type) {
        case SpawnpointType.character:
          player.position = spawnpoint.position;
          add(player);
          break;

        case SpawnpointType.fruit:
          final fruit = Fruit(
            position: spawnpoint.position,
            size: spawnpoint.size,
            fruit: FruitName.values.byName(spawnpoint.name),
          );

          add(fruit);

          break;

        case SpawnpointType.trap:
          final moveRangeTiles =
              spawnpoint.properties.getValue("moveRangeTiles");
          final isVerticalMove =
              spawnpoint.properties.getValue("isVerticalMove");
          final trap = Saw(
            position: spawnpoint.position,
            size: spawnpoint.size,
            type: TrapType.values.byName(spawnpoint.name),
            moveRangeTiles: moveRangeTiles,
            isVerticalMove: isVerticalMove,
          );
          add(trap);
          break;
      }
    }
  }

  void _loadCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('collisions');

    if (collisionsLayer == null) {
      throw Exception('Collisions layer not found');
    }

    for (final collision in collisionsLayer.objects) {
      if (collision.class_.isEmpty) {
        return;
      }

      final EnvironmentType type =
          EnvironmentType.values.byName(collision.class_);

      switch (type) {
        case EnvironmentType.platform:
          _createPlatformCollision(collision: collision);
          break;
        case EnvironmentType.block:
          _createBlockCollision(collision: collision);
          break;
      }
    }
  }

  void _createPlatformCollision({required TiledObject collision}) {
    final EnvironmentPlatformEnum type =
        EnvironmentPlatformEnum.values.byName(collision.name);
    switch (type) {
      case EnvironmentPlatformEnum.oneway:
        final platform = EnvironmentPlatform(
          position: collision.position,
          size: Vector2(collision.width, collision.height),
        );
        add(platform);
        break;
    }
  }

  void _createBlockCollision({required TiledObject collision}) {
    final EnvironmentBlockEnum type =
        EnvironmentBlockEnum.values.byName(collision.name);
    switch (type) {
      case EnvironmentBlockEnum.solid:
      case EnvironmentBlockEnum.ground:
      case EnvironmentBlockEnum.boundary:
        final block = EnvironmentBlock(
          position: collision.position,
          size: Vector2(collision.width, collision.height),
          type: type,
        );
        add(block);
        break;
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
}
