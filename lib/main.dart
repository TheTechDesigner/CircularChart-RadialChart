import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Circular Chart (Radial Chart)';

  final GlobalKey<AnimatedCircularChartState> _key = GlobalKey<AnimatedCircularChartState>();

  final _size = Size(400.0, 400.0);

  Color _label = Colors.deepPurple;

  double value = 50.0;

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data =  _chartData(value);
      _key.currentState.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data =  _chartData(value);
      _key.currentState.updateData(data);
    });
  }

  List<CircularStackEntry> _chartData(double value) {
    Color _color = Color(0xFFC41A3B);
    if (value < 0) {
      _color = Color(0xFFC41A3B);
    } else if (value < 50) {
      _color = Color(0xFF1B1F32);
    }
    _label = _color;

    List<CircularStackEntry> _data = <CircularStackEntry>[
      CircularStackEntry(<CircularSegmentEntry>[
        CircularSegmentEntry(value, _color, rankKey: 'Percentage')
      ], rankKey: 'Percentage')
    ];

    if (value > 100) {
      _label = Color(0xFF1B1F32);

      _data.add(CircularStackEntry(<CircularSegmentEntry>[
        CircularSegmentEntry(value - 100, Color(0xFF1B1F32),
            rankKey: 'Percentage')
      ], rankKey: 'Percentage'));
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: AnimatedCircularChart(
                key: _key,
                size: _size,
                initialChartData: _chartData(value),
                holeLabel: '$value',
                percentageValues: true,
                edgeStyle: SegmentEdgeStyle.round,
                chartType: CircularChartType.Radial,
                labelStyle: TextStyle(
                  color: _label,
                  fontSize: 64.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: _decrement,
                  child: Icon(
                    Icons.remove,
                  ),
                  color: Color(0xFFC41A3B),
                  textColor: Color(0xFFFBE0E6),
                  shape: CircleBorder(),
                ),
                RaisedButton(
                  onPressed: _increment,
                  child: Icon(
                    Icons.add,
                  ),
                  color: Color(0xFFC41A3B),
                  textColor: Color(0xFFFBE0E6),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
