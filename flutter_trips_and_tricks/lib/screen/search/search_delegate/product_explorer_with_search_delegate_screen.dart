// lib/screens/product_list_page_with_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resource/product_model.dart';
import 'product_provider_with_search_delegate.dart';
import 'product_search_delegate.dart';

class ProductListPageWithSearchDelegate extends StatelessWidget {
  const ProductListPageWithSearchDelegate({super.key});

  void _startSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: ProductSearchDelegate(),
    ).then((selectedProduct) {
      if (selectedProduct != null && selectedProduct.id != -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: ${selectedProduct.name}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _startSearch(context),
          ),
        ],
      ),
      body: const ProductListView(),
    );
  }
}

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<ProductProviderWithSearchDelegate>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !provider.isLoading) {
        provider.loadMoreItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProviderWithSearchDelegate>(
      builder: (context, provider, child) {
        return ListView.builder(
          controller: _scrollController,
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

            final Product product = provider.displayedProducts[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text(product.description),
              trailing: Text('\$${product.price.toStringAsFixed(2)}'),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
