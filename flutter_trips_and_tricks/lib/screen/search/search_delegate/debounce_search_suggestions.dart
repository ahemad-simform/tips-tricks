// lib/screens/debounced_search_suggestions.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../resource/product_model.dart';

class DebouncedSearchSuggestions extends StatefulWidget {
  final String query;
  final Function(Product) onSelected;
  final Future<List<Product>> Function(String) getSuggestions;

  const DebouncedSearchSuggestions({
    Key? key,
    required this.query,
    required this.onSelected,
    required this.getSuggestions,
  }) : super(key: key);

  @override
  _DebouncedSearchSuggestionsState createState() =>
      _DebouncedSearchSuggestionsState();
}

class _DebouncedSearchSuggestionsState
    extends State<DebouncedSearchSuggestions> {
  Timer? _debounce;
  List<Product> _suggestions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _handleQueryChange(widget.query);
  }

  @override
  void didUpdateWidget(covariant DebouncedSearchSuggestions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      _handleQueryChange(widget.query);
    }
  }

  void _handleQueryChange(String query) {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    // Start a new debounce timer
    setState(() {
      _isLoading = true;
    });

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final suggestions = await widget.getSuggestions(query);
      if (mounted) {
        setState(() {
          _suggestions = suggestions;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_suggestions.isEmpty) {
      return const Center(child: Text('No suggestions found'));
    }

    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final product = _suggestions[index];
        return ListTile(
          title: Text(product.name),
          onTap: () => widget.onSelected(product),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
