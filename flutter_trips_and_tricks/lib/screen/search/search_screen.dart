import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/screen/search/search_delegate/product_explorer_with_search_delegate_screen.dart';
import 'package:flutter_trips_and_tricks/screen/search/resource/mock_products.dart';

import 'custom_search/product_explorer_with_custom_search_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Search Demo'),
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
                    builder: (context) =>
                        const ProductListPageWithSearchDelegate(),
                  ),
                );
              },
              child: const Text("Product List Page With Search Delegate"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductListPageWithCustomSearch(products: mockProducts),
                  ),
                );
              },
              child: const Text("Product List Page With Custom Search"),
            ),
          ],
        ),
      ),
    );
  }
}
