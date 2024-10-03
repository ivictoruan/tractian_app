import 'package:flutter/material.dart';

class TreeLinePainter extends CustomPainter {
  final int depth;

  TreeLinePainter({required this.depth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ..color = Colors.black.withOpacity(0.06)
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Desenha uma linha vertical até o meio do nó pai
    canvas.drawLine(
      const Offset(0, 0),
      Offset(
        0,
        (depth == 0 ? size.height : size.height),
      ),
      paint,
    );

    // Se houver filhos, desenhe a linha horizontal
    if (size.height > 0 && depth != 0) {
      // Desenha a linha horizontal
      canvas.drawLine(
        Offset(
          0,
          size.height,
        ),
        Offset(
          0,
          size.height,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
