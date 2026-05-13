// This class is for different enums in the game.
// enum NumberType { none, one, two, three, four, five }

enum Difficulty { easy, medium, hard }

const Map<int, String> numberToWord = {
  1: 'one',
  2: 'two',
  3: 'three',
  4: 'four',
  5: 'five',
  6: 'six',
  7: 'seven',
  8: 'eight',
  9: 'nine',
  10: 'ten',
  11: 'eleven',
  12: 'twelve',
  13: 'thirteen',
  14: 'fourteen',
  15: 'fifteen',
  16: 'sixteen',
  17: 'seventeen',
  18: 'eighteen',
  19: 'nineteen',
  20: 'twenty',
};

// Define 3 levels of difficulty, and an extension 'settings' for easy access.
extension DifficultyExtension on Difficulty {
  DifficultySettings get settings {
    switch (this) {
      case Difficulty.easy:
        return const DifficultySettings(
          speed: 360,
          jumpSpeed: -640,
          gravity: 690,
          numberInterval: 4.0,
          scorePerObstacle: 5,
        );
      case Difficulty.medium:
        return const DifficultySettings(
          speed: 430,
          jumpSpeed: -690,
          gravity: 740,
          numberInterval: 3.0,
          scorePerObstacle: 7,
        );
      case Difficulty.hard:
        return const DifficultySettings(
          speed: 500,
          jumpSpeed: -730,
          gravity: 880,
          numberInterval: 2.0,
          scorePerObstacle: 10,
        );
    }
  }
}

// Structure of difficulty.
class DifficultySettings {
  final double speed;
  final double jumpSpeed;
  final double gravity;
  final double numberInterval;
  final int scorePerObstacle;

  const DifficultySettings({
    required this.speed,
    required this.jumpSpeed,
    required this.gravity,
    required this.numberInterval,
    required this.scorePerObstacle,
  });
}
