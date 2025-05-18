enum CharacterState {
  idle("Idle", 11),
  run("Run", 12),
  doubleJump("Double Jump", 6),
  fall("Fall", 1),
  hit("Hit", 7),
  jump("Jump", 1),
  wallJump("Wall Jump", 5),
  appearing("Appearing", 7),
  desapearing("Desappearing", 7);

  final String value;
  final int animationSequenceAmount;

  const CharacterState(this.value, this.animationSequenceAmount);
}

enum CharacterName {
  maskDude("Mask Dude"),
  ninjaFrog("Ninja Frog"),
  pinkMan("Pink Man"),
  virtualGuy("Virtual Guy");

  final String value;

  const CharacterName(this.value);
}

enum CharacterDirection {
  left,
  right,
  none,
}

class CharacterConfig {
  final CharacterName name;
  final double stepTime;
  final double speed;
  final double jumpForce;

  CharacterConfig({
    required this.name,
    this.stepTime = 0.05,
    this.speed = 100,
    this.jumpForce = 200,
  });

  CharacterConfig copyWith({
    CharacterDirection? direction,
  }) {
    return CharacterConfig(
      name: name,
      // state: state,
      stepTime: stepTime,
      speed: speed,
    );
  }
}
