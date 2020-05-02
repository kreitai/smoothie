library smoothie;

import 'dart:math';

import 'package:bezier/bezier.dart';
import 'package:vector_math/vector_math.dart';

class Smoothie {
  ///Creates a sampled curve going through the [originalDataPoints].
  ///
  ///[oversamplingFactor] is a number of points of the resulting smoothed curve per single point of the original curve
  ///[originalDataPoints] is a list of the original points
  ///
  ///Returns a list of [oversamplingFactor] * [originalDataPoints.length] points that lay on a curve going through the [originalDataPoints].
  List<Point> getSampledCurve(num oversamplingFactor,
      List<Point> originalDataPoints,) {
    var sampledCurve = List<Point>();
    for (int sc = 0; sc < originalDataPoints.length - 1; sc++) {
      var curve = new CubicBezier(
        [
          //start
          Vector2(0, originalDataPoints[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2,
              originalDataPoints[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2,
              originalDataPoints[sc + 1].y.toDouble()),
          //end
          Vector2(oversamplingFactor.toDouble(),
              originalDataPoints[sc + 1].y.toDouble()),
        ],
      );
      for (int j = 0; j < oversamplingFactor; j++) {
        sampledCurve.add(Point((sc * oversamplingFactor + j).toDouble(),
            curve.pointAt((j * 1 / oversamplingFactor).toDouble())[1]));
      }
    }
    return sampledCurve;
  }
}
