import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/recognizer_model/recognizer_model.dart';
import 'package:flutter_riderapp/Models/storke/stroke_model.dart';
import 'package:ink/ink.dart';

class HandwritingCanvas extends StatefulWidget {
  final List<Stroke> strokes; // List to store user-drawn strokes
  final void Function(List<Stroke> strokes) onUpdate; // Callback for updates

  const HandwritingCanvas({
    Key? key,
    required this.strokes,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<HandwritingCanvas> createState() => _HandwritingCanvasState();
}

class _HandwritingCanvasState extends State<HandwritingCanvas> {
  final _recognizer = Recognizer(); // For potential future text recognition

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: GestureDetector(
        onPanStart: (details) => _recognizer.write(details.localPosition),
        onPanUpdate: (details) => _recognizer.write(details.localPosition),
        onPanEnd: (details) {
          final strokes = _recognizer.strokes;
          widget.onUpdate(strokes);
          _recognizer.clear(); // Clear recognizer on gesture end
        },
        child: RepaintBoundary(
          child: CustomPaint(
            painter: HandwritingPainter(strokes: widget.strokes),
          ),
        ),
      ),
    );
  }
}

class HandwritingPainter extends CustomPainter {
  final List<Stroke> strokes;

  const HandwritingPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      canvas.drawPath(
          stroke.path,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(HandwritingPainter oldDelegate) =>
      oldDelegate.strokes != strokes;
}
