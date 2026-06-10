import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class MenuButton extends PositionComponent with TapCallbacks, HoverCallbacks {
  final String label;
  final VoidCallback onTapAction;
  final Color baseColor;

  bool _isHovered = false;

  MenuButton({
    required this.label,
    required this.onTapAction,
    required super.position,
    Color? backgroundColor,
  }) : baseColor = backgroundColor ?? Color(0xFF9D92F5),
       super(size: Vector2(230, 50), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 1. Draw Rounded Rectangle Button Background
    final paint = Paint()..color = _isHovered ? Color(0xFFCBC5F4) : baseColor;
    final rrect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(10),
    );
    canvas.drawRRect(rrect, paint);

    // 2. Render Text Label Perfectly Centered
    final textPainter = TextPaint(
      style: const TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.render(
      canvas,
      label,
      Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
  }

  @override
  void onHoverEnter() {
    _isHovered = true;
  }

  @override
  void onHoverExit() {
    _isHovered = false;
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTapAction(); // Execute the button behavior
  }
}
