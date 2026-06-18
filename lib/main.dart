import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:shape_theory/game/number_theory_game.dart';

final game = NumberTheoryGame();

void main() {
  runApp(GameWidget(game: game));
}
