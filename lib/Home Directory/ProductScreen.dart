import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Home%20Directory/ProductCard.dart';

import 'Models/Products_Model.dart';
import 'api_call.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: FutureBuilder<List<ProductsModel>>(
        future: fetchProducts(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No products found"));
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
