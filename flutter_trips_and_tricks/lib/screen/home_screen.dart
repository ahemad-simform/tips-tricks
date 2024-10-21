import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/screen/env_example/env_screen.dart';
import 'package:flutter_trips_and_tricks/screen/fps/fps_screen.dart';
import 'sealed_class_and_destructuring/check_out_screen.dart';
import 'package:flutter_trips_and_tricks/widgets/app_list_tile.dart';

import 'search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tips And Tricks'),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        children: [
          AppListTile(
            btnTitle: 'Env Example',
            btnOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EnvScreen(),
                ),
              );
            },
          ),
          AppListTile(
            btnTitle: 'FPS Example',
            btnOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FPSScreen(),
                ),
              );
            },
          ),
          AppListTile(
            btnTitle: 'Enum, Sealed Class and Desructuring',
            btnOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckOutScreen(),
                ),
              );
            },
          ),
          AppListTile(
            btnTitle: 'Search Delegate',
            btnOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
