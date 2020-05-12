///Create and sample a smooth Bézier curve going through a given set of points
library smoothie;

import 'dart:math';

import 'package:bezier/bezier.dart';
import 'package:vector_math/vector_math.dart';

extension SmoothPoints on List<Point> {
  ///Creates a sampled curve going through list of points.
  ///
  ///[oversamplingFactor] is a number of points of the resulting smoothed curve per single point of the original curve
  ///
  ///Returns a list of [oversamplingFactor] * this.length points that lay on a curve going through the given points.
  List<Point<num>> getSampledCurveFromPoints(
    num oversamplingFactor,
  ) {
    var sampledCurve = List<Point>();
    for (int sc = 0; sc < this.length - 1; sc++) {
      var curve = new CubicBezier(
        [
          Vector2(0, this[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2, this[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2, this[sc + 1].y.toDouble()),
          Vector2(oversamplingFactor.toDouble(), this[sc + 1].y.toDouble()),
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

extension Smooth<POINT> on List<POINT> {
  ///Creates a sampled curve going through list of custom data points.
  ///
  ///[oversamplingFactor] is a number of points of the resulting smoothed curve per single point of the original curve
  ///[mappingFunction] is a function that maps a custom data type [POINT] to [Point]<[num]>
  ///
  ///Returns a list of [oversamplingFactor] * this.length points that lay on a curve going through the given points.
  List<Point<num>> getSampledCurve(num oversamplingFactor,
      Point<num> Function(POINT point) mappingFunction) {
    var sampledCurve = List<Point>();
    var mappedDataPoints = this.map(mappingFunction).toList();
    for (int sc = 0; sc < this.length - 1; sc++) {
      var curve = new CubicBezier(
        [
          Vector2(0, mappedDataPoints[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2, mappedDataPoints[sc].y.toDouble()),
          Vector2(oversamplingFactor.toDouble() / 2, mappedDataPoints[sc + 1].y.toDouble()),
          Vector2(oversamplingFactor.toDouble(), mappedDataPoints[sc + 1].y.toDouble()),
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
