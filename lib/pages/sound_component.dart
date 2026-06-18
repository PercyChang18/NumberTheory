import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/game_storage.dart';
import 'package:shape_theory/game/number_theory_game.dart';

// Sound page to turn on / off the sound.
class SoundComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  SoundComponent() : super(size: Vector2(1280, 800));

  @override
  FutureOr<void> onLoad() {
    final double centerX = size.x / 2;
    final bool soundEnabled = Configuration.soundEnabled;
    add(
      TextComponent(
        text: 'Sound',
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
        label: "ON",
        onTapAction: () {
          Configuration.soundEnabled = true;
          GameStorage.saveSoundPreference(true);
          game.startBgm();
          game.soundPage.removeFromParent();
          game.showSoundPage();
        },
        position: Vector2(centerX, 400),
        backgroundColor: soundEnabled
            ? Configuration.activeColor
            : Configuration.inactiveColor,
      ),
    );
    add(
      MenuButton(
        label: "OFF",
        onTapAction: () {
          Configuration.soundEnabled = false;
          GameStorage.saveSoundPreference(false);
          game.stopBgm();
          game.soundPage.removeFromParent();
          game.showSoundPage();
        },
        position: Vector2(centerX, 480),
        backgroundColor: soundEnabled
            ? Configuration.inactiveColor
            : Configuration.activeColor,
      ),
    );

    add(
      MenuButton(
        label: 'BACK TO MENU',
        position: Vector2(centerX, 560),
        onTapAction: () {
          game.soundPage.removeFromParent();
          game.showMainMenu();
        },
      ),
    );
  }
}
