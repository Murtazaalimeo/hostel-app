import 'package:flutter/material.dart';

class DayNightModeScreen extends StatefulWidget {
  @override
  _DayNightModeScreenState createState() => _DayNightModeScreenState();
}

class _DayNightModeScreenState extends State<DayNightModeScreen> {
  bool isNightModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day/Night Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enable Night Mode',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: isNightModeEnabled,
              onChanged: (value) {
                setState(() {
                  isNightModeEnabled = value;
                });
                // Handle night mode logic
                if (isNightModeEnabled) {

                  // Apply night mode theme
                  // e.g., set ThemeMode.dark using Provider or MaterialApp's theme
                } else {

                  // Apply light mode theme
                  // e.g., set ThemeMode.light using Provider or MaterialApp's theme
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
