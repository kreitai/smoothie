[![pub package](https://img.shields.io/pub/v/smoothie.svg)](https://pub.dartlang.org/packages/smoothie)

# smoothie

Create and sample a smooth bezier curve going through a given set of points

## Usage

Let's say you have some arbitrary data (a list of points):

```dart
var _originalDataSeries = <Point>[
    Point(0, 5),
    Point(3, 15),
    Point(5, 10),
    Point(6, 6),
    Point(9, 13),
  ];
```

Define a desired number of samples in the resulting curve:

```dart
int _sampleCount = 100;
```
Import `smoothie`:

```
import 'package:smoothie/smoothie.dart';
```

Create a smooth curve using the `getSampledCurveFromPoints` extension function on your original data:

```dart
List<Point<num>> _sampledCurve = _originalDataSeries.smooth(_sampleCount);
```

See oversampling in action:

<img src="https://raw.githubusercontent.com/alekskuzmin/smoothie/master/example/example.gif" width="270" height="480">
