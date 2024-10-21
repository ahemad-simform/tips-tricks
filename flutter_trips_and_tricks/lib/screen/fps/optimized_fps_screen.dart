import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptimizedFPSScreen extends StatefulWidget {
  const OptimizedFPSScreen({super.key});

  @override
  _OptimizedFPSScreenState createState() => _OptimizedFPSScreenState();
}

class _OptimizedFPSScreenState extends State<OptimizedFPSScreen> {
  int counter = 0;
  String computationResult = "Not computed";

  // Heavy computation function
  String heavyComputation(int value) {
    double result = 0;
    for (int i = 0; i < 10000000; i++) {
      result += sqrt(i.toDouble());
    }
    return "Computed: $result";
  }

  // Perform heavy computation asynchronously
  Future<void> _performComputation() async {
    String result = await compute(heavyComputation, counter);
    setState(() {
      computationResult = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _performComputation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimized FPS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: $counter', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(computationResult, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++; // Triggers minimal rebuild
          });
          _performComputation(); // Perform computation asynchronously
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
