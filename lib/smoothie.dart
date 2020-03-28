library smoothie;

import 'dart:math';

import 'package:bezier/bezier.dart';
import 'package:vector_math/vector_math.dart';

class Smoothie {
  List<Point> getSampledCurve(
      num sectionPointsCount, List<Point> originalDataPoints) {
    var sampledCurve = List<Point>();
    for (int sc = 0; sc < originalDataPoints.length - 1; sc++) {
      var curve = new CubicBezier(
        [
          //start
          Vector2(0, originalDataPoints[sc].y.toDouble()),
          Vector2(sectionPointsCount.toDouble() / 2,
              originalDataPoints[sc].y.toDouble()),
          Vector2(sectionPointsCount.toDouble() / 2,
              originalDataPoints[sc + 1].y.toDouble()),
          //end
          Vector2(sectionPointsCount.toDouble(),
              originalDataPoints[sc + 1].y.toDouble()),
        ],
      );
      for (int j = 0; j < sectionPointsCount; j++) {
        sampledCurve.add(Point((sc * sectionPointsCount + j).toDouble(),
            curve.pointAt((j * 1 / sectionPointsCount).toDouble())[1]));
      }
    }
    return sampledCurve;
  }
}
