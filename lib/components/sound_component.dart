import 'dart:async';

import 'package:flame/components.dart';
import 'package:shape_theory/components/menu_button.dart';
import 'package:shape_theory/game/number_theory_game.dart';

class SoundComponent extends PositionComponent
    with HasGameReference<NumberTheoryGame> {
  SoundComponent() : super(size: Vector2(1280, 800));

  @override
  FutureOr<void> onLoad() {
    final double centerX = size.x / 2;
    add(TextComponent(text: 'SOUND'));

    add(
      MenuButton(
        label: "ON",
        onTapAction: () {},
        position: Vector2(centerX, 400),
      ),
    );
    add(
      MenuButton(
        label: "OFF",
        onTapAction: () {},
        position: Vector2(centerX, 400),
      ),
    );
  }
}
