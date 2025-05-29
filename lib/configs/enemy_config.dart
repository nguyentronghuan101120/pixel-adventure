import 'package:flame/components.dart';

enum EnemyType {
  angryPig('AngryPig'),
  bat('Bat'),
  bee('Bee'),
  blueBird('BlueBird'),
  bunny('Bunny'),
  chameleon('Chameleon'),
  chicken('Chicken'),
  duck('Duck'),
  fatBird('FatBird'),
  ghost('Ghost'),
  mushroom('Mushroom'),
  plant('Plant'),
  radish('Radish'),
  rino('Rino'),
  rocks('Rocks'),
  skull('Skull'),
  slime('Slime'),
  snail('Snail'),
  trunk('Trunk'),
  turtle('Turtle');

  final String value;

  const EnemyType(this.value);
}

enum EnemyState {
  idle,
  hit,
  run,
  walk,
  attack,
  death,
}

class AnimationFrame {
  final String imageName;
  final int animationSequenceAmount;
  final Vector2 textureSize;
  final bool canLoop;
  AnimationFrame(
      {required this.imageName,
      required this.animationSequenceAmount,
      required this.textureSize,
      this.canLoop = true});
}

class EnemyAnimationConfig {
  final EnemyType type;
  final Map<EnemyState, List<AnimationFrame>> animations;

  const EnemyAnimationConfig({required this.type, required this.animations});
}

extension EnemyAnimationConfigExtension on EnemyType {
  EnemyAnimationConfig get animationConfig => switch (this) {
        EnemyType.chicken => enemyChicken,
        EnemyType.angryPig => throw UnimplementedError(),
        EnemyType.bat => throw UnimplementedError(),
        EnemyType.bee => throw UnimplementedError(),
        EnemyType.blueBird => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.bunny => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.chameleon => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.duck => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.fatBird => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.ghost => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.mushroom => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.plant => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.radish => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.rino => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.rocks => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.skull => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.slime => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.snail => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.trunk => throw UnimplementedError(),
        // TODO: Handle this case.
        EnemyType.turtle => throw UnimplementedError(),
      };
}

final enemyChicken = EnemyAnimationConfig(
  type: EnemyType.chicken,
  animations: {
    EnemyState.idle: [
      AnimationFrame(
        imageName: 'Idle (32x34)',
        animationSequenceAmount: 13,
        textureSize: Vector2(32, 34),
      ),
    ],
    EnemyState.hit: [
      AnimationFrame(
        imageName: 'Hit (32x34)',
        animationSequenceAmount: 5,
        textureSize: Vector2(32, 34),
        canLoop: false,
      ),
    ],
    EnemyState.run: [
      AnimationFrame(
        imageName: 'Run (32x34)',
        animationSequenceAmount: 14,
        textureSize: Vector2(32, 34),
      ),
    ],
  },
);
