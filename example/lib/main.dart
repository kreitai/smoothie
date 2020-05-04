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
      home: SmoothieHomePage(title: 'Smoothie Demo'),
    );
  }
}

class SmoothieHomePage extends StatefulWidget {
  SmoothieHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SmoothieHomePageState createState() => _SmoothieHomePageState();
}

class _SmoothieHomePageState extends State<SmoothieHomePage> {
  int _samplesPerPoint = 0;

  var originalDataSeries = <Point>[
    Point(0, 5),
    Point(3, 15),
    Point(5, 10),
    Point(6, 6),
    Point(9, 13),
  ];

  @override
  void initState() {
    super.initState();
    _samplesPerPoint = 10;
  }

  void _incrementCounter() {
    setState(() {
      _samplesPerPoint++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_samplesPerPoint > 1) _samplesPerPoint--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      new charts.Series(
        domainFn: (Point chartData, _) => chartData.x / _samplesPerPoint,
        measureFn: (Point chartData, _) => chartData.y,
        colorFn: (Point point, _) => charts.MaterialPalette.teal.shadeDefault,
        id: 'Example Series',
        data: originalDataSeries.getSampledCurveFromPoints(
          _samplesPerPoint,
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
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'The curve now has $_samplesPerPoint sampling points per original point.',
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
