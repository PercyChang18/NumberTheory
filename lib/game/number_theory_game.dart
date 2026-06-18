import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:shape_theory/components/background.dart';
import 'package:shape_theory/pages/difficulty_component.dart';
import 'package:shape_theory/pages/high_score_component.dart';
import 'package:shape_theory/pages/main_menu_component.dart';
import 'package:shape_theory/pages/sound_component.dart';
import 'package:shape_theory/game/assets.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/game_loop.dart';
import 'package:shape_theory/game/game_storage.dart';

class NumberTheoryGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, MouseMovementDetector {
  late GameLoop gameLoop;
  late Background background;
  late MainMenuComponent mainMenu;
  late HighScoreComponent highScore;
  late SoundComponent soundPage;
  late DifficultyComponent difficultyPage;
  bool isPlaying = false;
  static final Vector2 windowSize = Vector2(1280, 800);

  @override
  Future<void> onLoad() async {
    debugPrint(size.toString());
    camera = CameraComponent.withFixedResolution(
      width: windowSize.x,
      height: windowSize.y,
    );

    camera.viewfinder.anchor = Anchor.topLeft;
    Configuration.currentDifficulty = await GameStorage.loadDifficulty();
    Configuration.soundEnabled = await GameStorage.loadSoundPreference();
    world.add(background = Background()..priority = -1);

    await FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load(Assets.bgm);

    if (Configuration.soundEnabled) {
      startBgm();
    }

    showMainMenu();
  }

  // Methods to navigating through different pages.
  void showMainMenu() {
    world.add(mainMenu = MainMenuComponent());
  }

  void showHighScores() {
    mainMenu.removeFromParent();
    world.add(highScore = HighScoreComponent());
  }

  void showSoundPage() {
    mainMenu.removeFromParent();
    world.add(soundPage = SoundComponent());
  }

  void showDifficultyPage() {
    mainMenu.removeFromParent();
    world.add(difficultyPage = DifficultyComponent());
  }

  // start / stop bgm.
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
    mainMenu.removeFromParent();
    world.add(gameLoop = GameLoop());
  }
}
