import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:shape_theory/game/assets.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';

class Background extends ParallaxComponent<NumberTheoryGame> {
  Background();

  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [ParallaxImageData(Assets.background)],
      baseVelocity: Vector2(Configuration.backgroundSpeed, 0),
      // velocityMultiplierDelta: Vector2(1.8, 0),
    );
  }
}
