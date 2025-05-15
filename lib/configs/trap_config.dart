enum TrapType {
  arrow(
    "Arrow",
    "shoots arrows",
    8,
    0.1,
    32,
    32,
  ),
  blocks(
    "Blocks",
    "blocks path",
    6,
    0.12,
    32,
    32,
  ),
  fallingPlatforms(
    "Falling Platforms",
    "platforms fall",
    4,
    0.15,
    32,
    32,
  ),
  fan(
    "Fan",
    "blows air",
    10,
    0.08,
    32,
    32,
  ),
  fire(
    "Fire",
    "burns",
    6,
    0.09,
    32,
    32,
  ),
  platforms(
    "Platforms",
    "moves up and down",
    6,
    0.13,
    32,
    32,
  ),
  rockHead(
    "Rock Head",
    "charges forward",
    8,
    0.11,
    32,
    32,
  ),
  sandMudIce(
    "Sand Mud Ice",
    "slows movement",
    4,
    0.14,
    32,
    32,
  ),
  saw(
    "Saw",
    "On (38x38)",
    8,
    0.07,
    38,
    38,
  ),
  spikeHead(
    "Spike Head",
    "pops up",
    6,
    0.1,
    32,
    32,
  ),
  spikeBall(
    "Spike Ball",
    "swings",
    8,
    0.03,
    38,
    38,
  ),
  spikes(
    "Spikes",
    "damages on contact",
    4,
    0.12,
    32,
    32,
  ),
  trampoline(
    "Trampoline",
    "bounces player",
    6,
    0.1,
    32,
    32,
  );

  final String value;
  final String actionAnimation;
  final int animationAmount;
  final double animationStepTime;
  final double textureSizeHeight;
  final double textureSizeWidth;

  const TrapType(
    this.value,
    this.actionAnimation,
    this.animationAmount,
    this.animationStepTime,
    this.textureSizeHeight,
    this.textureSizeWidth
  );
}
