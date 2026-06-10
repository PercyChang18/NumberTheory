import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/game/assets.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';

class MainMenuComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  MainMenuComponent() : super(size: Vector2(1280, 800));

  @override
  Future<void> onLoad() async {
    final double centerX = size.x / 2;
    final icon = await game.loadSprite(Assets.icon);
    add(
      SpriteComponent(
        sprite: icon,
        size: Vector2(420, 360),
        position: Vector2(centerX, 200),
        anchor: Anchor.center,
      ),
    );
    add(
      TextComponent(
        text: 'DIFFICULTY',
        position: Vector2(centerX, 300),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    add(
      TextComponent(
        text: Configuration.currentDifficulty.name.toUpperCase(),
        position: Vector2(centerX, 330),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );

    add(
      MenuButton(
        label: 'START GAME',
        position: Vector2(centerX, 400),
        onTapAction: () => game.startGame(),
      ),
    );

    add(
      MenuButton(
        label: 'DIFFICULTY',
        position: Vector2(centerX, 480),
        onTapAction: () => game.showDifficultyPage(),
      ),
    );

    add(
      MenuButton(
        label: 'HIGH SCORE',
        position: Vector2(centerX, 560),
        onTapAction: () => game.showHighScores(),
      ),
    );

    add(
      MenuButton(
        label: 'SOUND',
        position: Vector2(centerX, 640),
        onTapAction: () => game.showSoundPage(),
      ),
    );
  }
}
