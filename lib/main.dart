import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/pages/difficulty_page.dart';
import 'package:shape_theory/pages/game_over_page.dart';
import 'package:shape_theory/pages/high_score_page.dart';
import 'package:shape_theory/pages/main_menu_page.dart';
import 'package:shape_theory/pages/sound_page.dart';

final game = NumberTheoryGame();

void main() {
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: [MainMenuPage.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuPage(game: game),
        'gameOver': (context, _) => GameOverPage(game: game),
        'difficulty': (context, _) => DifficultyPage(game: game),
        'highScore': (context, _) => HighScorePage(game: game),
        'sound': (context, _) => SoundPage(game: game),
      },
    ),
  );
}
