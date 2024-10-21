import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/widgets/app_list_tile.dart';

import '../../env/env.dart';

// https://www.ezyzip.com/

class EnvScreen extends StatelessWidget {
  const EnvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Env Example'),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        children: [
          AppListTile(
            btnTitle: 'Print Env Variables',
            btnOnTap: () {
              // Flutter_dot_env
              // debugPrint(dotenv.env['Key1']);
              // debugPrint(dotenv.env['Key2']);

              // Envied
              debugPrint(Env.key1);
              debugPrint(Env.key2);
            },
          ),
        ],
      ),
    );
  }
}
