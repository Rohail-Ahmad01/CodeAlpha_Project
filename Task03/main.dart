import 'package:flutter/material.dart';

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fitness Tracker',style: TextStyle(color: Colors.blue),)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogActivityScreen()),
              ),
              child: Text('Log Activity'),
            ),
            SizedBox(height: 20),
            Text('Daily Progress: 7000 steps'),
          ],
        ),
      ),
    );
  }
}

class LogActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log Activity')),
      body: Center(
        child: Text('Here, users can log workouts, steps, and calories burned.'),
      ),
    );
  }
}