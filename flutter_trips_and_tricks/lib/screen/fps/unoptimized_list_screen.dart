import 'package:flutter/material.dart';

class UnoptimizedListViewScreen extends StatelessWidget {
  final List<int> items = List.generate(1000, (index) => index);

  UnoptimizedListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unoptimized ListView (FPS Drops)'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildUnoptimizedListItem(index);
        },
      ),
    );
  }

  Widget _buildUnoptimizedListItem(int index) {
    // Introducing deep nesting and heavy computation directly in the widget tree
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          _deeplyNestedWidget(index),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueAccent,
                  child: Text('Item $index'),
                ),
                _expensiveComputation(
                    index), // Causes jank by blocking main thread
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Deeply nested structure adds to the rendering overhead
  Widget _deeplyNestedWidget(int index) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              color: Colors.red,
              child: Text('$index'),
            ),
          ],
        ),
      ],
    );
  }

  // Simulating an expensive computation directly in the widget
  Widget _expensiveComputation(int index) {
    int result = 0;
    for (int i = 0; i < 10000000; i++) {
      result += index * i; // Blocking main thread by computation
    }
    return Text('Computation: $result');
  }
}
