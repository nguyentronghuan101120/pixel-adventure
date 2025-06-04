enum GameOverlay {
  menu,
  levelSelection,
  gameComplete,
  joystick,
  jumpButton,
  backButton;

  String get name => switch (this) {
        menu => 'MenuScreen',
        levelSelection => 'LevelSelectionScreen',
        gameComplete => 'GameCompleteScreen',
        joystick => 'Joystick',
        jumpButton => 'JumpButton',
        backButton => 'BackButton',
      };
}
