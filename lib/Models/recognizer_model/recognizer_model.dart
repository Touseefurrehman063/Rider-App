import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/storke/stroke_model.dart';

class Recognizer {
  final List<Stroke> _strokes = [];
  Path _currentPath = Path();
  final Color _currentColor = Colors.black;
  final double _currentStrokeWidth = 2.0;

  List<Stroke> get strokes => _strokes;

  void write(Offset offset) {
    _currentPath.lineTo(offset.dx, offset.dy);
  }

  void clear() {
    _strokes.clear();
  }

  void endStroke() {
    _strokes.add(Stroke(
      path: _currentPath,
      color: _currentColor,
      strokeWidth: _currentStrokeWidth,
    ));
    _currentPath = Path();
  }
}
