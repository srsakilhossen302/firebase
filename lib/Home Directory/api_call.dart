import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Models/Products_Model.dart';

const String _baseUrl = 'https://fakestoreapi.com';

/// Fetch all products
Future<List<ProductsModel>> fetchProducts() async {
  final response = await http.get(Uri.parse('$_baseUrl/products'));
  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => ProductsModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products. Status: ${response.statusCode}');
  }
}

/// Fetch products by category
Future<List<ProductsModel>> fetchProductsByCategory(String category) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/products/category/$category'),
  );
  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => ProductsModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products by category.');
  }
}

/// Fetch all available categories
Future<List<String>> fetchCategories() async {
  final response = await http.get(Uri.parse('$_baseUrl/products/categories'));
  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => e.toString()).toList();
  } else {
    throw Exception('Failed to load categories.');
  }
}

/// Fetch a single product by ID
Future<ProductsModel> fetchProductById(int id) async {
  final response = await http.get(Uri.parse('$_baseUrl/products/$id'));
  if (response.statusCode == 200) {
    return ProductsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load product.');
  }
}
