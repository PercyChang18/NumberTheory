import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:shape_theory/game/assets.dart';
import 'package:shape_theory/game/configuration.dart';
import 'package:shape_theory/game/number_theory_game.dart';
import 'package:shape_theory/game/types.dart';

class Ground extends ParallaxComponent<NumberTheoryGame> {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(ParallaxImage(ground, fill: LayerFill.none)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Configuration.currentDifficulty.settings.speed;
  }
}
