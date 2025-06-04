import 'package:flutter/material.dart';
import 'package:pixel_adventure/gen/assets.gen.dart';

enum MenuType {
  start,
  chooseLevel,
  back,
  restart,
  next,
  menu,
}

extension MenuTypeExtension on MenuType {
  Color get color => switch (this) {
        MenuType.start => const Color(0xFFE6E6FA),
        MenuType.chooseLevel => const Color(0xFFFFD1DC),
        MenuType.back => const Color(0xFFE6E6FA),
        MenuType.restart => const Color(0xFFFFD700),
        MenuType.next => const Color(0xFF00FF00),
        MenuType.menu => const Color(0xFFE6E6FA),
      };

  String get name => switch (this) {
        MenuType.start => 'START',
        MenuType.chooseLevel => 'CHOOSE LEVEL',
        MenuType.back => 'BACK',
        MenuType.restart => 'RESTART',
        MenuType.next => 'NEXT',
        MenuType.menu => 'MENU',
      };

  Widget get icon => switch (this) {
        MenuType.back => Assets.images.menu.buttons.back.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        MenuType.start => Assets.images.menu.buttons.play.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        MenuType.chooseLevel => Assets.images.menu.buttons.levels.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        MenuType.restart => Assets.images.menu.buttons.play.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        MenuType.next => Assets.images.menu.buttons.play.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        MenuType.menu => Assets.images.menu.buttons.back.image(
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
      };
}
