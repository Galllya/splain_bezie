import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFancyPainter extends CustomPainter {
  final List<int>? x;
  final List<int>? y;
  final bool? showPoints;
  final bool? showLines;
  final Offset? offset;
  final bool isSplain;
  final bool? showSer, showOtnos, showP;

  MyFancyPainter({
    this.x,
    this.y,
    this.showPoints,
    this.showLines,
    this.offset,
    required this.isSplain,
    this.showOtnos,
    this.showP,
    this.showSer,
  });

  Offset getPoint(List<int> x, List<int> y, double t, int maxPoints) {
    if (t < 0) t = 0;
    if (t > 1) t = 1;
    double needParam = 1 - t;
    double xNow = pow(needParam, 3) * x[maxPoints - 4] +
        3 * pow(needParam, 2) * t * x[maxPoints - 3] +
        3 * needParam * pow(t, 2) * x[maxPoints - 2] +
        pow(t, 3) * x[maxPoints - 1];
    double yNow = pow(needParam, 3) * y[maxPoints - 4] +
        3 * pow(needParam, 2) * t * y[maxPoints - 3] +
        3 * needParam * pow(t, 2) * y[maxPoints - 2] +
        pow(t, 3) * y[maxPoints - 1];
    return Offset(xNow, yNow);
  }

  List<int> getX() {
    return x!;
  }

  List<int> getY() {
    return y!;
  }

  bool getShowPoints() {
    return showPoints!;
  }

  bool getShowLines() {
    return showLines!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isSplain) {
      const circleRadius = 2.0;
      final paint = Paint()
        ..strokeWidth = 5
        ..color = Colors.indigoAccent
        ..style = PaintingStyle.fill;
      final paintForPoints = Paint()
        ..strokeWidth = 10
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      int sigmentsNumber = 10000;
      final paintForLines = Paint()
        ..strokeWidth = 2
        ..color = Colors.green
        ..style = PaintingStyle.stroke;

      final paintForSerPoint = Paint()
        ..strokeWidth = 3
        ..color = Colors.pink
        ..style = PaintingStyle.stroke;
      final paintForOtnosPoint = Paint()
        ..strokeWidth = 8
        ..color = Colors.yellow
        ..style = PaintingStyle.stroke;
      final paintForPPoint = Paint()
        ..strokeWidth = 8
        ..color = Colors.black
        ..style = PaintingStyle.stroke;

      const circleRadiusForPoints = 6.0;

      List<double> xSer = [];
      List<double> ySer = [];
      if (x!.length > 1) {
        for (int i = 0; i < x!.length - 1; i++) {
          xSer.add((x![i] + x![i + 1]) / 2);
          ySer.add((y![i] + y![i + 1]) / 2);

          if (showSer!) {
            canvas.drawCircle(
                Offset(xSer[i], ySer[i]), circleRadius, paintForSerPoint);
          }
        }
      }

      List<double> xOtnos = [];
      List<double> yOtnos = [];
      if (x!.length > 2) {
        for (int i = 0; i < x!.length - 2; i++) {
          double xKouf =
              (x![i + 1] - x![i]).abs() / (x![i + 2] - x![i + 1]).abs();
          double yKouf =
              (y![i + 1] - y![i]).abs() / (y![i + 2] - y![i + 1]).abs();

          xOtnos.add((xSer[i + 1] * xKouf + xSer[i]) / (1 + xKouf));
          yOtnos.add((ySer[i + 1] * yKouf + ySer[i]) / (1 + yKouf));

          if (showOtnos!) {
            canvas.drawCircle(
                Offset(xOtnos[i], yOtnos[i]), circleRadius, paintForOtnosPoint);
          }
        }
      }

      List<double> xPoint1 = [];
      List<double> yPoint1 = [];
      List<double> xPoint2 = [];
      List<double> yPoint2 = [];
      if (x!.length > 2) {
        for (int i = 0; i < x!.length - 2; i++) {
          double xBetwenPointAndOtnos = (x![i + 1] - xOtnos[i]);
          double yBetwenPointAndOtnos = (y![i + 1] - yOtnos[i]);

          xPoint1.add((xBetwenPointAndOtnos + xSer[i]));
          yPoint1.add((yBetwenPointAndOtnos + ySer[i]));

          xPoint2.add((xBetwenPointAndOtnos + xSer[i + 1]));
          yPoint2.add((yBetwenPointAndOtnos + ySer[i + 1]));

          if (showP!) {
            canvas.drawCircle(
                Offset(xPoint1[i], yPoint1[i]), circleRadius, paintForPPoint);
            canvas.drawCircle(
                Offset(xPoint2[i], yPoint2[i]), circleRadius, paintForPPoint);
          }
        }
      }

      if (x!.length > 2) {
        List<int> xx = [];
        List<int> yy = [];
        for (int i = 0; i < x!.length - 3; i++) {
          xx.add(x![i + 1]);
          xx.add(xPoint2[i].toInt());
          xx.add(xPoint1[i + 1].toInt());

          xx.add(x![i + 2].toInt());
          yy.add(y![i + 1]);
          yy.add(yPoint2[i].toInt());

          yy.add(yPoint1[i + 1].toInt());
          yy.add(y![i + 2].toInt());
          for (int i = 0; i < sigmentsNumber; i++) {
            double paremeter = (i % sigmentsNumber) / sigmentsNumber;
            Offset circleCenter = getPoint(xx, yy, paremeter, 4);
            canvas.drawCircle(circleCenter, circleRadius, paint);
          }
          xx.clear();
          yy.clear();
        }
      }

      if (getShowPoints()) {
        for (int i = 0; i < x!.length; i++) {
          Offset circleCenter = Offset(x![i].toDouble(), y![i].toDouble());
          canvas.drawCircle(
              circleCenter, circleRadiusForPoints, paintForPoints);
        }
      }
      if (x!.length > 1) {
        if (getShowLines()) {
          for (int i = 0; i < x!.length - 1; i++) {
            Offset p1 = Offset(x![i].toDouble(), y![i].toDouble());
            Offset p2 = Offset(x![i + 1].toDouble(), y![i + 1].toDouble());
            canvas.drawLine(p1, p2, paintForLines);
          }
        }
      }
    } else {
      List<int> x = getX();
      List<int> y = getY();
      const circleRadius = 2.0;
      final paint = Paint()
        ..strokeWidth = 5
        ..color = Colors.indigoAccent
        ..style = PaintingStyle.fill;

      final paintForPoints = Paint()
        ..strokeWidth = 10
        ..color = Colors.red
        ..style = PaintingStyle.fill;

      final paintForLines = Paint()
        ..strokeWidth = 2
        ..color = Colors.green
        ..style = PaintingStyle.stroke;

      const circleRadiusForPoints = 6.0;

      if (getShowPoints()) {
        for (int i = 0; i < 4; i++) {
          Offset circleCenter = Offset(x[i].toDouble(), y[i].toDouble());
          canvas.drawCircle(
              circleCenter, circleRadiusForPoints, paintForPoints);
        }
      }

      if (getShowLines()) {
        for (int i = 0; i < 3; i++) {
          Offset p1 = Offset(x[i].toDouble(), y[i].toDouble());
          Offset p2 = Offset(x[i + 1].toDouble(), y[i + 1].toDouble());
          canvas.drawLine(p1, p2, paintForLines);
        }
      }

      int sigmentsNumber = 1000;

      for (int i = 0; i < sigmentsNumber; i++) {
        double paremeter = (i % sigmentsNumber) / sigmentsNumber;
        Offset circleCenter = getPoint(x, y, paremeter, 4);
        canvas.drawCircle(circleCenter, circleRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant MyFancyPainter oldDelegate) {
    if (oldDelegate.x != getX() || oldDelegate.y != getY()) {
      return true;
    } else {
      return true;
    }
  }
}
