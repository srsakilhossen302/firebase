import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Models/Products_Model.dart';

Future<List<ProductsModel>> fetchProducts() async {
  final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));

  if (response.statusCode == 200) {
    List jsonData = jsonDecode(response.body);
    return jsonData.map((e) => ProductsModel.fromJson(e)).toList();
  } else {
    throw Exception("Failed to load products");
  }
}
