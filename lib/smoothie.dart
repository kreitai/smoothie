///Create and sample a smooth Bézier curve going through a given set of points
library smoothie;

import 'dart:math';

import 'package:bezier/bezier.dart';
import 'package:vector_math/vector_math.dart';

extension SmoothPoints on List<Point> {
  ///Creates a sampled curve going through list of points.
  ///
  ///[sampleCount] is a number of points of the resulting smoothed curve
  ///
  ///Returns a list of length [sampleCount] points that lay on a curve going through the given points.
  List<Point<num>> smooth(
    num sampleCount, {
    bool isSorted = true,
  }) {
    if (!isSorted) {
      this.sort();
    }
    var sampleWidth = (this[this.length - 1].x - this[0].x) / sampleCount;
    var sampledCurve = List<Point>();
    for (int originalPointIndex = 0;
        originalPointIndex < this.length - 1;
        originalPointIndex++) {
      var currentIntervalWidth =
          (this[originalPointIndex + 1].x - this[originalPointIndex].x);
      int intervalSampleCount =
          max(1, (currentIntervalWidth / sampleWidth).round());
      var curve = new CubicBezier(
        [
          Vector2(0, this[originalPointIndex].y.toDouble()),
          Vector2(intervalSampleCount.toDouble() / 2,
              this[originalPointIndex].y.toDouble()),
          Vector2(intervalSampleCount.toDouble() / 2,
              this[originalPointIndex + 1].y.toDouble()),
          Vector2(intervalSampleCount.toDouble(),
              this[originalPointIndex + 1].y.toDouble()),
        ],
      );
      for (int oversamplingIndex = 0;
          oversamplingIndex <= intervalSampleCount;
          oversamplingIndex++) {
        sampledCurve.add(Point(
            (this[originalPointIndex].x +
                    currentIntervalWidth *
                        oversamplingIndex /
                        intervalSampleCount)
                .toDouble(),
            curve.pointAt(
                (oversamplingIndex / intervalSampleCount).toDouble())[1]));
      }
    }
    return sampledCurve;
  }
}