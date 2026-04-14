import 'package:flutter/material.dart';
import 'Models/Products_Model.dart';
import 'ProductCard.dart';
import 'api_call.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<ProductsModel>> _futureProducts;
  List<ProductsModel> _allProducts = [];
  List<ProductsModel> _filteredProducts = [];
  String _searchQuery = '';
  String _sortBy = 'default';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureProducts = _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<ProductsModel>> _loadProducts() async {
    _allProducts = await fetchProducts();
    _apply();
    return _allProducts;
  }

  void _apply() {
    List<ProductsModel> result = List.from(_allProducts);

    // Search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((p) =>
              p.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ==
              true)
          .toList();
    }

    // Sort
    switch (_sortBy) {
      case 'price_asc':
        result.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case 'price_desc':
        result.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'rating':
        result.sort(
            (a, b) => (b.rating?.rate ?? 0).compareTo(a.rating?.rate ?? 0));
        break;
      default:
        break;
    }
    setState(() => _filteredProducts = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'Sort by',
            onSelected: (value) {
              _sortBy = value;
              _apply();
            },
            itemBuilder: (context) => [
              _buildSortItem('default', 'Default', Icons.grid_view_rounded),
              _buildSortItem('price_asc', 'Price: Low → High', Icons.arrow_upward_rounded),
              _buildSortItem('price_desc', 'Price: High → Low', Icons.arrow_downward_rounded),
              _buildSortItem('rating', 'Top Rated', Icons.star_rounded),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<ProductsModel>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.deepPurple),
                  SizedBox(height: 12),
                  Text('Fetching products...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 60, color: Colors.grey),
                  const SizedBox(height: 12),
                  Text(
                    'Oops! Could not load products.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () =>
                        setState(() => _futureProducts = _loadProducts()),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    _searchQuery = val;
                    _apply();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search in products...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () {
                              _searchController.clear();
                              _searchQuery = '';
                              _apply();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),

              // Count row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      '${_filteredProducts.length} items',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                    ),
                    const Spacer(),
                    if (_sortBy != 'default')
                      Chip(
                        label: Text(
                          _sortBy == 'price_asc'
                              ? 'Price ↑'
                              : _sortBy == 'price_desc'
                                  ? 'Price ↓'
                                  : 'Top Rated',
                          style: const TextStyle(fontSize: 11),
                        ),
                        backgroundColor: Colors.deepPurple.shade50,
                        side: const BorderSide(color: Colors.deepPurple),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () {
                          _sortBy = 'default';
                          _apply();
                        },
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),

              // Grid
              Expanded(
                child: _filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off_rounded,
                                size: 60, color: Colors.grey.shade300),
                            const SizedBox(height: 12),
                            Text(
                              'No products match your search.',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                        itemCount: _filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) =>
                            ProductCard(product: _filteredProducts[index]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  PopupMenuItem<String> _buildSortItem(
      String value, String label, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Text(label),
          if (_sortBy == value) ...[
            const Spacer(),
            const Icon(Icons.check_rounded, size: 16, color: Colors.deepPurple),
          ],
        ],
      ),
    );
  }
}
