import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetBatteryLevel extends StatefulWidget {
  const GetBatteryLevel({Key? key}) : super(key: key);

  @override
  State<GetBatteryLevel> createState() => _GetBatteryLevelState();
}

class _GetBatteryLevelState extends State<GetBatteryLevel> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<dynamic> getBatteryLevel() async{
    String batteryLevel;
    try {
      final int result =  await platform.invokeMethod('getBatteryLevel') as int;
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}