library smoothie;

import 'dart:math';

import 'package:bezier/bezier.dart';
import 'package:vector_math/vector_math.dart';

extension Smooth on List<Point> {
  ///Creates a sampled curve going through the [originalDataPoints].
  ///
  ///[oversamplingFactor] is a number of points of the resulting smoothed curve per single point of the original curve
  ///[mappingFunction] is a function that maps a custom data type [T] to [Point]
  ///
  ///Returns a list of [oversamplingFactor] * [originalDataPoints.length] points that lay on a curve going through the [originalDataPoints].
  List<Point> getSampledCurve<T>(num oversamplingFactor, Function(Point<num> e) mappingFunction) {
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

  ///Creates a sampled curve going through the [originalDataPoints].
  ///
  ///[oversamplingFactor] is a number of points of the resulting smoothed curve per single point of the original curve
  ///[originalDataPoints] is a list of the original points
  ///
  ///Returns a list of [oversamplingFactor] * [originalDataPoints.length] points that lay on a curve going through the [originalDataPoints].
  List<Point> getSampledCurveFromPoints(
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
