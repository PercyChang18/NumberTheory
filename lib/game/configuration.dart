// Configuration of the game.
import 'package:flutter/material.dart';
import 'package:shape_theory/game/types.dart';

class Configuration {
  static const backgroundSpeed = 120.0;
  static const groundHeight = 260.0;

  static Difficulty currentDifficulty = Difficulty.easy;
  static bool soundEnabled = false;

  // Game button settings
  static const buttonWidth = 150.0;
  static const spacing = 100.0;
  static const totalWidth = buttonWidth * 3 + spacing * 2;

  static const activeColor = Color(0xFFCBC5F4);
  static const inactiveColor = Color(0xFF9D92F5);
}
