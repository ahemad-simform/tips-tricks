import 'dart:async';
import 'package:flutter/material.dart';
import '../resource/product_model.dart';

class ProductProviderForCustom with ChangeNotifier {
  final List<Product> allProducts;

  // Search related
  final TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];
  bool isSearching = false;
  final Map<String, List<Product>> cache = {};
  Timer? _debounce;

  // Lazy loading related
  final ScrollController scrollController = ScrollController();
  final List<Product> displayedProducts = [];
  final int itemsPerPage;
  int currentPage = 0;
  bool isLoading = false;

  ProductProviderForCustom({
    required this.allProducts,
    this.itemsPerPage = 20,
  }) {
    // Initialize listeners
    loadMoreItems();

    scrollController.addListener(_scrollListener);
    searchController.addListener(_onSearchChanged);
  }

  // Scroll Listener for Lazy Loading
  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        !isSearching) {
      loadMoreItems();
    }
  }

  // Search Listener with Debounce
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      performSearch(searchController.text);
    });
  }

  // Perform Search Operation
  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      isSearching = false;
      searchResults = [];
      notifyListeners();
      return;
    }

    if (cache.containsKey(query)) {
      searchResults = cache[query]!;
      isSearching = true;
      notifyListeners();
      return;
    }

    isSearching = true;
    notifyListeners();

    // Simulate network/database delay
    await Future.delayed(const Duration(milliseconds: 300));

    final results = allProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    cache[query] = results;
    searchResults = results;
    notifyListeners();
  }

  // Load More Items for Lazy Loading
  Future<void> loadMoreItems() async {
    isLoading = true;
    notifyListeners();

    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 500));

    final nextItems = allProducts
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();
    if (nextItems.isNotEmpty) {
      displayedProducts.addAll(nextItems);
      currentPage++;
    }

    isLoading = false;
    notifyListeners();
  }

  // Clear Search
  void clearSearch() {
    searchController.clear();
    isSearching = false;
    searchResults = [];
    notifyListeners();
  }

  // Properly dispose of resources
  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
