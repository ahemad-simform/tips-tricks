import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class OptimizedListViewScreen extends StatelessWidget {
  final List<int> items = List.generate(1000, (index) => index);

  OptimizedListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimized ListView (60 FPS)'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return RepaintBoundary(
            // Isolate repaint regions
            child: _buildOptimizedListItem(index),
          );
        },
      ),
    );
  }

  Widget _buildOptimizedListItem(int index) {
    // Simpler, more efficient layout, with offloaded computations
    return ListTile(
      key: ValueKey(index), // Use ValueKey to prevent unnecessary rebuilds
      leading: CircleAvatar(child: Text('$index')),
      title: Text('Item $index'),
      subtitle: FutureBuilder<int>(
        future: _performHeavyTask(index), // Offload computation
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Non-blocking UI loading
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Computation: ${snapshot.data}');
          }
        },
      ),
    );
  }

  // Offloading the computation to avoid main thread blocking
  Future<int> _performHeavyTask(int index) async {
    return await compute(_expensiveComputation, index); // Offloading to isolate
  }

  // Expensive computation runs in a separate isolate
  int _expensiveComputation(int index) {
    int result = 0;
    for (int i = 0; i < 10000000; i++) {
      result += index * i;
    }
    return result;
  }
}
