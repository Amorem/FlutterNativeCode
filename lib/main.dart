import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (error) {
      setState(() {
        _batteryLevel = null;
      });
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Code Demonstrator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: Text(
          'Battery Level: $_batteryLevel%',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
