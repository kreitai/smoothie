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

Define a number of sampling points per original point:

```dart
int _samplesPerPoint = 10;
```

Create a smooth curve:

```dart
var _sampledCurve = Smoothie().getSampledCurve(_samplesPerPoint, _originalDataSeries);
```

See oversampling in action:

![vertical](https://raw.githubusercontent.com/alekskuzmin/smoothie/master/example/example.gif)