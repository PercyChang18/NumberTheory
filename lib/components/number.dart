import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/types.dart';

class Number extends PositionComponent with HasGameReference<NumberTheoryGame> {
  final int number;
  late TextPainter _strokePainter;
  late TextPainter _textPainter;
  late double groundY;

  Number({required this.number}) : super(size: Vector2.all(200));
  @override
  Future<void> onLoad() async {
    _strokePainter = TextPainter(
      text: TextSpan(
        text: '$number',
        style: TextStyle(
          fontSize: size.x * 0.8,
          fontWeight: FontWeight.bold,
          fontFamily: 'PixelFont',
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth =
                4.0 // thickness of the outline
            ..color = Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Initialize the TextPainter for the number
    _textPainter = TextPainter(
      text: TextSpan(
        text: '$number',
        style: TextStyle(
          fontSize: size.x * 0.8,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    groundY = game.size.y - size.y + 10 - Configuration.groundHeight;
    position = Vector2(game.size.x, groundY);
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.5, size.y * 0.6),
        position: Vector2(size.x * 0.2, size.y * 0.2),
      ),
    );
  }

  // Color _getColor() {
  //   // Unique colors for numbers to help kids associate
  //   final colors = [
  //     Colors.orange,
  //     Colors.blue,
  //     Colors.green,
  //     Colors.red,
  //     Colors.purple,
  //     Colors.teal,
  //   ];
  //   return colors[number % colors.length];
  // }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw the number at the center of the component
    final offset = Offset(
      (size.x - _textPainter.width) / 2,
      (size.y - _textPainter.height) / 2,
    );

    _textPainter.paint(canvas, offset);
    _strokePainter.paint(canvas, offset);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Configuration.currentDifficulty.settings.speed * dt;

    if (position.x < -size.x) {
      // Logic to clear active number (replace with your GameState logic)
      removeFromParent();
      updateScore();
      debugPrint('Number $number Removed');
    }
  }

  void updateScore() {
    game.dino.score +=
        Configuration.currentDifficulty.settings.scorePerObstacle;
  }
}
