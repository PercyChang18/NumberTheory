import 'dart:async';

import 'package:flame/components.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/components/number.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';

// Game over page. It has a button to main menu and a button to replay the game.
class GameOverComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  GameOverComponent() : super(size: Vector2(1280, 720));

  @override
  FutureOr<void> onLoad() async {
    final double centerX = size.x / 2;
    add(
      MenuButton(
        label: 'Restart',
        onTapAction: () => onRestart(),
        position: Vector2(centerX, 100),
      ),
    );
    add(
      MenuButton(
        label: 'Back to Menu',
        onTapAction: () => backToMain(),
        position: Vector2(centerX, 180),
      ),
    );
  }

  void onRestart() {
    if (Configuration.soundEnabled) {
      game.startBgm();
    }
    game.gameLoop.dino.reset();
    game.gameLoop.children.query<Number>().forEach((p) => p.removeFromParent());
    game.gameLoop.buttonContainer?.removeFromParent();
    game.gameLoop.interval.stop(); // Stop the current ticking
    game.gameLoop.interval.reset(); // Put it back to 0:00
    game.gameLoop.interval.start();
    game.world.children.query<GameOverComponent>().forEach(
      (p) => p.removeFromParent(),
    );
    game.background.timeScale = 1.0;
    game.gameLoop.timeScale = 1.0;
    game.gameLoop.isPlaying = true;
  }

  void backToMain() {
    if (Configuration.soundEnabled) {
      game.startBgm();
    }
    game.gameLoop.isPlaying = false;
    game.gameLoop.children.query<Number>().forEach((p) => p.removeFromParent());
    game.gameLoop.buttonContainer?.removeFromParent();
    game.gameLoop.dino.removeFromParent();
    game.gameLoop.ground.removeFromParent();
    game.gameLoop.score.removeFromParent();
    game.world.children.query<GameOverComponent>().forEach(
      (p) => p.removeFromParent(),
    );
    game.background.timeScale = 1.0;
    game.showMainMenu();
  }
}
