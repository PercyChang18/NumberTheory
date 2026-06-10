import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/game_storage.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/types.dart';

class DifficultyComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  DifficultyComponent() : super(size: Vector2(1280, 800));

  @override
  FutureOr<void> onLoad() {
    final double centerX = size.x / 2;
    final Difficulty currentDifficulty = Configuration.currentDifficulty;

    add(
      TextComponent(
        text: 'DIFFICULTY',
        position: Vector2(centerX, 200),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    add(
      MenuButton(
        label: "EASY",
        onTapAction: () {
          Configuration.currentDifficulty = Difficulty.easy;
          GameStorage.saveDifficulty(Difficulty.easy);
          game.difficultyPage.removeFromParent();
          game.showDifficultyPage();
        },
        position: Vector2(centerX, 320),
        backgroundColor: currentDifficulty == Difficulty.easy
            ? Configuration.activeColor
            : Configuration.inactiveColor,
      ),
    );
    add(
      MenuButton(
        label: "MEDIUM",
        onTapAction: () {
          Configuration.currentDifficulty = Difficulty.medium;
          GameStorage.saveDifficulty(Difficulty.medium);
          game.difficultyPage.removeFromParent();
          game.showDifficultyPage();
        },
        position: Vector2(centerX, 400),
        backgroundColor: currentDifficulty == Difficulty.medium
            ? Configuration.activeColor
            : Configuration.inactiveColor,
      ),
    );
    add(
      MenuButton(
        label: "HARD",
        onTapAction: () {
          Configuration.currentDifficulty = Difficulty.hard;
          GameStorage.saveDifficulty(Difficulty.hard);
          game.difficultyPage.removeFromParent();
          game.showDifficultyPage();
        },
        position: Vector2(centerX, 480),
        backgroundColor: currentDifficulty == Difficulty.hard
            ? Configuration.activeColor
            : Configuration.inactiveColor,
      ),
    );

    add(
      MenuButton(
        label: 'BACK TO MENU',
        position: Vector2(centerX, 560),
        onTapAction: () {
          game.difficultyPage.removeFromParent();
          game.showMainMenu();
        },
      ),
    );
  }
}
