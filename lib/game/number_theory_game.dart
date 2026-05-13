import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/background.dart';
import 'package:shape_theory/components/dino.dart';
import 'package:shape_theory/components/ground.dart';
import 'package:shape_theory/components/jump_button.dart';
import 'package:shape_theory/components/number.dart';
import 'package:shape_theory/game/assets.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/game_storage.dart';
import 'package:shape_theory/game/types.dart';

class NumberTheoryGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  late Dino dino;
  late int activeNumber;
  late Ground ground;
  late TextComponent score;
  bool isPlaying = false;

  // For the 3 buttons group alone with each shape.
  PositionComponent? buttonContainer;
  Timer interval = Timer(
    Configuration.currentDifficulty.settings.numberInterval,
    repeat: true,
  );

  @override
  Future<void> onLoad() async {
    // debugMode = true;
    Configuration.currentDifficulty = await GameStorage.loadDifficulty();
    Configuration.soundEnabled = await GameStorage.loadSoundPreference();
    add(Background());

    await FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load(Assets.bgm);

    if (Configuration.soundEnabled) {
      startBgm();
    }
  }

  void startBgm() {
    FlameAudio.bgm.play(Assets.bgm, volume: 0.35);
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  @override
  void onRemove() {
    FlameAudio.bgm.dispose();
    super.onRemove();
  }

  // Start the game. This is only called when user starts the game from main menu.
  void startGame() {
    addAll([ground = Ground(), dino = Dino(), score = buildScore()]);
    interval.stop();
    interval.reset();
    interval.onTick = () => _spawnRandomNumber();
    interval.start();
    isPlaying = true;
  }

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
            620,
          ),
          number: numbers[i],
        ),
      );
    }

    add(Number(number: correctNumber));
  }

  void _spawnRandomNumber() {
    final randomNum = 1 + Random().nextInt(20);
    spawnNumberAndButtons(randomNum);
  }

  // Generate 3 buttons: 1 correct number, 2 unique incorrect numbers
  List<int> generateRandomNumberButtons(int correctNumber) {
    List<int> results = [correctNumber];

    while (results.length < 3) {
      int randomIncorrect = 1 + Random().nextInt(10);
      // Ensure we don't pick the correct number or a duplicate incorrect one
      if (!results.contains(randomIncorrect)) {
        results.add(randomIncorrect);
      }
    }

    results.shuffle();
    return results;
  }

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
    }
  }
}
