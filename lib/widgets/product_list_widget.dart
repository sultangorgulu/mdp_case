import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdp_case/widgets/product_card.dart';
import 'package:mdp_case/models/products.dart';
import 'package:mdp_case/widgets/showallproducts_widget.dart'; 

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'popular products'.tr,
                
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.indigo[300]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAllProducts(
                        futureProducts: futureProducts,
                      ),
                    ),
                  );
                },
                child: Text(
                  'show all'.tr,
                  style: const TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                final limitedProducts = products.take(10).toList();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: limitedProducts.length,
                  itemBuilder: (context, index) {
                    final product = limitedProducts[index];
                    return ProductCard(
                      product: product,
                    );
                  },
                );
              } else {
                return const Center(child: Text('No products found'));
              }
            },
          ),
        ),
      ],
    );
  }
}
