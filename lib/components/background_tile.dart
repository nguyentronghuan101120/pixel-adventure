import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/configs/background_config.dart';
import 'package:pixel_adventure/game/pixel_adventure.dart';

class BackgroundTile extends SpriteComponent
    with HasGameReference<PixelAdventure> {
  final BackgroundColor color;
  BackgroundTile({
    required Vector2 position,
    required this.color,
    required Vector2 velocity,
  }) : super(position: position);

  final double scrollSpeed = 0.4;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(65);
    // The anchor is set to Anchor.topLeft so that the position of the BackgroundTile
    // corresponds to its top-left corner, which makes it easier to align tiles in a grid.
    anchor = Anchor.topLeft;
    sprite = Sprite(game.images.fromCache("Background/${color.value}.png"));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed;

    // If the tile moves below the bottom edge of the screen, wrap it to the top
    if (position.y > game.size.y) position.y = -size.y;
    // If the tile moves above the top edge of the screen, wrap it to the bottom
    if (position.y < -size.y) position.y = game.size.y;
    // If the tile moves beyond the right edge of the screen, wrap it to the left
    if (position.x > game.size.x) position.x = -size.x;
    // If the tile moves beyond the left edge of the screen, wrap it to the right
    if (position.x < -size.x) position.x = game.size.x;
    super.update(dt);
  }
}
