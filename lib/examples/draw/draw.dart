import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({Key? key}) : super(key: key);

  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  final _controller = Get.put(_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: _controller.onPanStart,
        onPanUpdate: _controller.onPanUpdate,
        onPanEnd: _controller.onPanEnd,
        child: SizedBox.expand(
          child: Obx(
            () => CustomPaint(
              painter: _Painter(_controller.points.toList()),
            ),
          ),
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final List<_Model?> points;

  _Painter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i]!.offset, points[i + 1]!.offset, points[i]!.paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
          PointMode.points,
          [points[i]!.offset],
          points[i]!.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Model {
  final Offset offset;
  final Paint paint;

  _Model({
    required this.offset,
    required this.paint,
  });
}

class _Controller extends GetxController {
  final points = <_Model?>[].obs;
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4.0
    ..strokeCap = StrokeCap.round;

  void onPanStart(DragStartDetails d) {
    final model = _Model(offset: d.localPosition, paint: paint);
    points.add(model);
  }

  void onPanUpdate(DragUpdateDetails d) {
    final model = _Model(offset: d.localPosition, paint: paint);
    points.add(model);
  }

  void onPanEnd(DragEndDetails d) {
    points.add(null);
  }
}
