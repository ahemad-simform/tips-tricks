// lib/providers/product_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../resource/product_model.dart';

class ProductProviderWithSearchDelegate extends ChangeNotifier {
  final List<Product> _allProducts;
  final List<Product> _displayedProducts = [];
  final Map<String, List<Product>> _searchCache = {};

  final int _itemsPerPage = 20;
  int _currentPage = 0;
  bool _isLoading = false;

  ProductProviderWithSearchDelegate(this._allProducts) {
    loadMoreItems();
  }

  List<Product> get displayedProducts => _displayedProducts;
  bool get isLoading => _isLoading;

  void loadMoreItems() {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    // Simulate delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final nextItems = _allProducts
          .skip(_currentPage * _itemsPerPage)
          .take(_itemsPerPage)
          .toList();
      _displayedProducts.addAll(nextItems);
      _currentPage++;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<List<Product>> searchProducts(String query) async {
    if (_searchCache.containsKey(query)) {
      return _searchCache[query]!;
    }

    // Simulate network/database delay
    await Future.delayed(const Duration(milliseconds: 300));

    final results = _allProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    _searchCache[query] = results;
    return results;
  }

  Future<List<Product>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    if (_searchCache.containsKey(query)) {
      return _searchCache[query]!
          .where((product) =>
              product.name.toLowerCase().startsWith(query.toLowerCase()))
          .take(10)
          .toList();
    }

    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 300));

    final suggestions = _allProducts
        .where((product) =>
            product.name.toLowerCase().startsWith(query.toLowerCase()))
        .take(10)
        .toList();

    _searchCache[query] = suggestions;
    return suggestions;
  }
}
