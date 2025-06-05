import 'package:shared_preferences/shared_preferences.dart';

class LevelProgressService {
  static const String _currentLevelKey = 'current_level';
  static const String _unlockedLevelsKey = 'unlocked_levels';
  static const String _completedLevelsKey = 'completed_levels';
  static const String _soundEnabledKey = 'sound_enabled';

  final SharedPreferences _prefs;

  LevelProgressService(this._prefs);

  static Future<LevelProgressService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LevelProgressService(prefs);
  }

  int getCurrentLevel() {
    return _prefs.getInt(_currentLevelKey) ?? 1;
  }

  Future<void> setCurrentLevel(int level) async {
    await _prefs.setInt(_currentLevelKey, level);
  }

  List<int> getUnlockedLevels() {
    final String? unlockedLevelsStr = _prefs.getString(_unlockedLevelsKey);
    if (unlockedLevelsStr == null) {
      return [1]; // First level is always unlocked
    }
    return unlockedLevelsStr.split(',').map(int.parse).toList();
  }

  Future<void> unlockLevel(int level) async {
    final unlockedLevels = getUnlockedLevels();
    if (!unlockedLevels.contains(level)) {
      unlockedLevels.add(level);
      unlockedLevels.sort();
      await _prefs.setString(_unlockedLevelsKey, unlockedLevels.join(','));
    }
  }

  bool isLevelUnlocked(int level) {
    return getUnlockedLevels().contains(level);
  }

  List<int> getCompletedLevels() {
    final String? completedLevelsStr = _prefs.getString(_completedLevelsKey);
    if (completedLevelsStr == null) {
      return [];
    }
    return completedLevelsStr.split(',').map(int.parse).toList();
  }

  Future<void> markLevelAsCompleted(int level) async {
    final completedLevels = getCompletedLevels();
    if (!completedLevels.contains(level)) {
      completedLevels.add(level);
      completedLevels.sort();
      await _prefs.setString(_completedLevelsKey, completedLevels.join(','));

      // Automatically unlock the next level when completing current level
      await unlockLevel(level + 1);
    }
  }

  bool isLevelCompleted(int level) {
    return getCompletedLevels().contains(level);
  }

  bool isSoundEnabled() {
    return _prefs.getBool(_soundEnabledKey) ?? false; // Default to true
  }

  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_soundEnabledKey, enabled);
  }

  Future<void> resetProgress() async {
    await _prefs.remove(_currentLevelKey);
    await _prefs.remove(_unlockedLevelsKey);
    await _prefs.remove(_completedLevelsKey);
    // Don't reset sound settings
  }
}
