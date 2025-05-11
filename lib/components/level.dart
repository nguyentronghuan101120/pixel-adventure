import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/character.dart';
import 'package:pixel_adventure/components/environments/environment_block.dart';
import 'package:pixel_adventure/components/environments/environment_platform.dart';
import 'package:pixel_adventure/configs/enviroment_config.dart';

class Level extends World {
  late TiledComponent level;

  Level({
    required this.player,
    required this.levelNumber,
  });

  final Character player;
  final int levelNumber;

  final List<EnvironmentPlatform> platforms = [];
  final List<EnvironmentBlock> blocks = [];

  @override
  void onLoad() async {
    level = await TiledComponent.load(
      'level$levelNumber.tmx',
      Vector2.all(16),
    );
    add(level);
    _loadSpawnpoints();
    _loadCollisions();
  }

  void _loadSpawnpoints() {
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>('spawnpoints');

    if (spawnpointsLayer == null) {
      throw Exception('Spawnpoints layer not found');
    }

    for (final spawnpoint in spawnpointsLayer.objects) {
      switch (spawnpoint.name) {
        case 'player':
          player.position = spawnpoint.position;
          add(player);
          break;
        default:
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
        platforms.add(platform);
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
        blocks.add(block);
        add(block);
        break;
    }
  }
}
