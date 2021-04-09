[![pub package](https://img.shields.io/pub/v/smoothie.svg)](https://pub.dartlang.org/packages/smoothie)

# smoothie

Create and sample a smooth Bézier curve going through a given set of points

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

Full example using the `charts_flutter` package:

```dart
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:smoothie/smoothie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smoothie Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SmoothieHomePage(),
    );
  }
}

class SmoothieHomePage extends StatefulWidget {
  SmoothieHomePage({Key? key}) : super(key: key);

  @override
  _SmoothieHomePageState createState() => _SmoothieHomePageState();
}

class _SmoothieHomePageState extends State<SmoothieHomePage> {
  int _samplingPointCount = 0;

  var _originalDataSeries = <Point>[
    Point(0, 5),
    Point(2, 15),
    Point(3, 10),
    Point(8, 6),
    Point(9, 13),
  ];

  @override
  void initState() {
    super.initState();
    _samplingPointCount = _originalDataSeries.length;
  }

  void _incrementCounter() {
    setState(() {
      _samplingPointCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_samplingPointCount > _originalDataSeries.length)
        _samplingPointCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      new charts.Series(
        domainFn: (Point chartData, _) => chartData.x,
        measureFn: (Point chartData, _) => chartData.y,
        colorFn: (Point point, _) => charts.MaterialPalette.teal.shadeDefault,
        id: 'Example Series',
        data: _originalDataSeries.smooth(
          _samplingPointCount,
        ),
      ),
    ];

    var chart = new charts.LineChart(
      series,
      animate: false,
      defaultRenderer: new charts.LineRendererConfig(
        includeArea: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Smoothie Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'The smooth curve now has $_samplingPointCount points.',
              ),
              Container(
                height: 200,
                child: chart,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ));
  }
}
```

If you want to run the example as is and you are using null safety, you have to pass `--no-sound-null-safety` to the build command as the current version of `charts_flutter` does not yet support null safety:
```console
cd example
flutter run --no-sound-null-safety
```

