import 'package:flutter/material.dart';

import 'optimized_fps_screen.dart';
import 'unoptimized_fps_screen.dart';
import 'optimized_list_screen.dart';
import 'unoptimized_list_screen.dart';

class FPSScreen extends StatelessWidget {
  const FPSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FPS Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UnoptimizedFPSScreen(),
                  ),
                );
              },
              child: const Text("Un-Optimized FPS"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnoptimizedListViewScreen(),
                  ),
                );
              },
              child: const Text("Un-Optimized ListView FPS"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OptimizedFPSScreen(),
                  ),
                );
              },
              child: const Text("Optimized FPS"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptimizedListViewScreen(),
                  ),
                );
              },
              child: const Text("Optimized ListView FPS"),
            ),
          ],
        ),
      ),
    );
  }
}
