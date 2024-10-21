import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/screen/search/custom_search/product_provider_for_custom.dart';
import 'package:provider/provider.dart';
import '../resource/product_model.dart';

class ProductListPageWithCustomSearch extends StatelessWidget {
  final List<Product> products;

  const ProductListPageWithCustomSearch({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProviderForCustom>(
      create: (_) => ProductProviderForCustom(allProducts: products),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Explorer'),
        ),
        body: const Column(
          children: [
            SearchBarWidget(),
            Expanded(
              child: ProductListViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductProviderForCustom>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: provider.searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Consumer<ProductProviderForCustom>(
            builder: (context, provider, child) {
              return provider.isSearching
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        provider.clearSearch();
                      },
                    )
                  : SizedBox.fromSize();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

class ProductListViewWidget extends StatelessWidget {
  const ProductListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProviderForCustom>(
      builder: (context, provider, child) {
        if (provider.isSearching) {
          if (provider.searchResults.isEmpty) {
            return const Center(child: Text('No results found'));
          }
          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              final product = provider.searchResults[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${product.name}')),
                  );
                },
              );
            },
          );
        } else {
          return ListView.builder(
            controller: provider.scrollController,
            itemCount: provider.displayedProducts.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.displayedProducts.length) {
                return provider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }

              final product = provider.displayedProducts[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        }
      },
    );
  }
}
