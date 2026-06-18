import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/dino.dart';
import 'package:shape_theory/components/ground.dart';
import 'package:shape_theory/components/jump_button.dart';
import 'package:shape_theory/components/number.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/types.dart';

// This component is the core gameplay loop. It starts the game, generates obstacle (number) with cooresponding buttons, and displaying the score.
class GameLoop extends PositionComponent
    with
        HasGameReference<NumberTheoryGame>,
        HasCollisionDetection,
        HasTimeScale {
  late Dino dino;
  late int activeNumber;
  late Ground ground;
  late TextComponent score;
  bool isPlaying = false;

  PositionComponent? buttonContainer;

  // rate of number obstacle generation
  Timer interval = Timer(
    Configuration.currentDifficulty.settings.numberInterval,
    repeat: true,
  );

  GameLoop() : super(size: Vector2(1280, 800));

  @override
  FutureOr<void> onLoad() async {
    addAll([ground = Ground(), dino = Dino(), score = buildScore()]);
    interval.stop();
    interval.reset();
    interval.onTick = () => _spawnRandomNumber();
    interval.start();
    isPlaying = true;
  }

  // Generate a random number and call the spawnNumberAndButtons method to create the obstacle and buttons.
  void _spawnRandomNumber() {
    final randomNum = 1 + Random().nextInt(20);
    spawnNumberAndButtons(randomNum);
  }

  // Spawn the number obstacle and 3 buttons to the game world.
  Future<void> spawnNumberAndButtons(int correctNumber) async {
    activeNumber = correctNumber;

    buttonContainer?.removeFromParent();
    buttonContainer = PositionComponent();
    add(buttonContainer!);

    final numbers = generateRandomNumberButtons(correctNumber);
    double startX = (size.x - Configuration.totalWidth) / 2;

    for (int i = 0; i < numbers.length; i++) {
      buttonContainer!.add(
        JumpButton(
          label: numberToWord[numbers[i]]!,
          position: Vector2(
            startX + (Configuration.buttonWidth + Configuration.spacing) * i,
            size.y - 100,
          ),
          number: numbers[i],
        ),
      );
    }

    add(Number(number: correctNumber));
  }

  // Generate list of 3 numbers for buttons: 1 correct number, 2 unique incorrect numbers
  List<int> generateRandomNumberButtons(int correctNumber) {
    List<int> results = [correctNumber];

    while (results.length < 3) {
      int randomIncorrect = 1 + Random().nextInt(20);
      // Ensure we don't pick the correct number or a duplicate incorrect one
      if (!results.contains(randomIncorrect)) {
        results.add(randomIncorrect);
      }
    }

    results.shuffle();
    return results;
  }

  // Build the score text to display on screen.
  TextComponent buildScore() {
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 10, (size.y / 2) * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isPlaying) {
      interval.update(dt);
      score.text = 'Score: ${dino.score}';
    } else {
      return;
    }
  }
}
