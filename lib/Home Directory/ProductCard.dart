import 'dart:ui';
import 'package:flutter/material.dart';
import 'Models/Products_Model.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              product.image ?? "",
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    // Star rating
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          size: 16,
                          color: index <
                              (product.rating?.rate ?? 0).round()
                              ? Colors.amber
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${product.rating?.count ?? 0}",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
