import 'package:flutter/material.dart';

import 'package:flutter_trips_and_tricks/screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'screen/search/resource/mock_products.dart';
import 'screen/search/search_delegate/product_provider_with_search_delegate.dart';

void main() async {
  // await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProviderWithSearchDelegate(mockProducts),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      //  const ShowFPS(
      //   alignment: Alignment.topRight,
      //   visible: false,
      //   showChart: false,
      //   borderRadius: BorderRadius.all(Radius.circular(11)),
      //   child: HomeScreen(),
      // ),
    );
  }
}
