import 'package:flutter/material.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/game_storage.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/types.dart';
import 'package:shape_theory/main.dart';

// Page to set the difficuly.
class DifficultyPage extends StatefulWidget {
  final NumberTheoryGame game;
  static const String id = 'difficulty';
  const DifficultyPage({super.key, required this.game});

  @override
  State<DifficultyPage> createState() => _DifficultyPageState();
}

class _DifficultyPageState extends State<DifficultyPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DIFFICULTY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              _difficultyButton(Difficulty.easy),
              SizedBox(height: 20),
              _difficultyButton(Difficulty.medium),
              SizedBox(height: 20),
              _difficultyButton(Difficulty.hard),

              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D92F5),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(230, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  game.overlays.remove('difficulty');
                  game.overlays.add('mainMenu');
                },
                child: Text('Back to Menu', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _difficultyButton(Difficulty level) {
    // The selected difficulty will have different color.
    bool isSelected = Configuration.currentDifficulty == level;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Color.fromARGB(255, 203, 197, 244)
            : Color(0xFF9D92F5),
        foregroundColor: Colors.white,
        minimumSize: Size(230, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Configuration.currentDifficulty = level;
        GameStorage.saveDifficulty(level);
        setState(() {});
      },
      child: Text(level.name.toUpperCase(), style: TextStyle(fontSize: 25)),
    );
  }
}
