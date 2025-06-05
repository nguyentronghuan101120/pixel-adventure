import 'package:flame_audio/flame_audio.dart';

enum SoundName {
  jump('jump.wav'),
  hit('hit.wav'),
  collect('collect.wav'),
  complete('complete.wav'),
  background('background.mp3');

  final String value;

  const SoundName(this.value);
}

extension SoundNameExtension on SoundName {
  void play(SoundConfig soundConfig) {
    if (soundConfig.hasSound) {
      FlameAudio.play(value, volume: soundConfig.volume);
    }
  }
}

class SoundConfig {
  final bool hasSound;
  final double volume;

  SoundConfig({
    this.hasSound = false,
    this.volume = 1.0,
  });

  SoundConfig copyWith({
    bool? hasSound,
    double? volume,
  }) {
    return SoundConfig(
      hasSound: hasSound ?? this.hasSound,
      volume: volume ?? this.volume,
    );
  }
}
