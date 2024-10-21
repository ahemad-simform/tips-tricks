import 'dart:math';

import 'package:flutter/material.dart';

class UnoptimizedFPSScreen extends StatefulWidget {
  const UnoptimizedFPSScreen({super.key});

  @override
  _UnoptimizedFPSScreenState createState() => _UnoptimizedFPSScreenState();
}

class _UnoptimizedFPSScreenState extends State<UnoptimizedFPSScreen> {
  int counter = 0;

  // Simulate heavy computation
  void _heavyComputation() {
    // Intensive loop
    for (int i = 0; i < 10000000; i++) {
      sqrt(i.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    _heavyComputation(); // Called on every build, blocking the UI thread

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unoptimized FPS'),
      ),
      body: Center(
        child: Text(
          'Counter: $counter',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++; // Triggers a rebuild
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
