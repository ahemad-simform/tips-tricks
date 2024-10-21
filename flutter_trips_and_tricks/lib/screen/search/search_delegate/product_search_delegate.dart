// lib/screens/product_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resource/product_model.dart';
import 'debounce_search_suggestions.dart';
import 'product_provider_with_search_delegate.dart';

class ProductSearchDelegate extends SearchDelegate<Product> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(
          context, Product(id: -1, name: '', description: '', price: 0.0)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider =
        Provider.of<ProductProviderWithSearchDelegate>(context, listen: false);

    return FutureBuilder<List<Product>>(
      future: provider.searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final product = results[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                onTap: () => close(context, product),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider =
        Provider.of<ProductProviderWithSearchDelegate>(context, listen: false);

    return DebouncedSearchSuggestions(
      query: query,
      onSelected: (Product product) {
        query = product.name;
        showResults(context);
      },
      getSuggestions: provider.getSuggestions,
    );
  }
}
