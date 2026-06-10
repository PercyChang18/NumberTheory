import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/game_storage.dart';

class HighScoreComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  HighScoreComponent() : super(size: Vector2(1280, 800));

  static const _headerStyle = TextStyle(
    fontSize: 36,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const _bodyStyle = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final double centerX = size.x / 2;

    // 1. Screen Title Text
    // add(
    //   TextComponent(
    //     text: 'HIGH SCORES',
    //     position: Vector2(centerX, 150),
    //     anchor: Anchor.center,
    //     textRenderer: TextPaint(
    //       style: const TextStyle(
    //         fontSize: 70,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );

    // 2. Table Headers (Rank, Score, Date)
    // Placed at absolute positions to form clear vertical columns
    add(
      TextComponent(
        text: 'RANK',
        position: Vector2(centerX - 400, 70),
        anchor: Anchor.center,
        textRenderer: TextPaint(style: _headerStyle),
      ),
    );
    add(
      TextComponent(
        text: 'SCORE',
        position: Vector2(centerX, 70),
        anchor: Anchor.center,
        textRenderer: TextPaint(style: _headerStyle),
      ),
    );
    add(
      TextComponent(
        text: 'DATE',
        position: Vector2(centerX + 400, 70),
        anchor: Anchor.center,
        textRenderer: TextPaint(style: _headerStyle),
      ),
    );

    // 3. Load Async Data natively in the onLoad sequence
    final scores = await GameStorage.loadScores();

    if (scores.isEmpty) {
      add(
        TextComponent(
          text: 'No Scores Yet, Play The Game!',
          position: Vector2(centerX, 400),
          anchor: Anchor.center,
          textRenderer: TextPaint(style: _bodyStyle),
        ),
      );
    } else {
      double currentY = 120;
      final maxDisplayRows = scores.length < 10 ? scores.length : 10;

      for (int i = 0; i < maxDisplayRows; i++) {
        final entry = scores[i];
        final rank = i + 1;
        final scoreVal = entry['score']?.toString() ?? '0';
        final dateVal = entry['date']?.toString() ?? '---';

        add(
          TextComponent(
            text: '$rank',
            position: Vector2(centerX - 400, currentY),
            anchor: Anchor.center,
            textRenderer: TextPaint(style: _bodyStyle),
          ),
        );
        add(
          TextComponent(
            text: scoreVal,
            position: Vector2(centerX, currentY),
            anchor: Anchor.center,
            textRenderer: TextPaint(style: _bodyStyle),
          ),
        );
        add(
          TextComponent(
            text: dateVal,
            position: Vector2(centerX + 400, currentY),
            anchor: Anchor.center,
            textRenderer: TextPaint(style: _bodyStyle),
          ),
        );

        currentY += 55; // Push next table row downwards
      }
    }

    add(
      MenuButton(
        label: 'BACK TO MENU',
        position: Vector2(centerX, 720),
        onTapAction: () {
          game.highScore.removeFromParent();
          game.showMainMenu();
        },
      ),
    );
  }
}
