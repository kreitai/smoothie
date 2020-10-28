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
  int _samplingPointCount = 0;

  var originalDataSeries = <Point>[
    Point(0, 5),
    Point(2, 15),
    Point(3, 10),
    Point(8, 6),
    Point(9, 13),
  ];

  @override
  void initState() {
    super.initState();
    _samplingPointCount = originalDataSeries.length;
  }

  void _incrementCounter() {
    setState(() {
      _samplingPointCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_samplingPointCount > originalDataSeries.length) _samplingPointCount--;
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
        data: originalDataSeries.smooth(
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
          title: Text(widget.title),
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
