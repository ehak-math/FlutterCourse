import 'package:flutter/material.dart';

enum Product {
  dart(
    title: 'Dart',
    image: 'assets/images/dart.png',
    description: 'the best object language',
  ),
  flutter(
    title: 'Flutter',
    image: 'assets/images/flutter.png',
    description: 'the best moblie widget library',
  ),
  firebase(
    title: 'Firebase',
    image: 'assets/images/firebase.png',
    description: 'the best cloud database',
  );

  final String title;
  final String image;
  final String description;

  const Product({
    required this.title,
    required this.image,
    required this.description,
  });
}


void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductCard(product: Product.dart,),
              SizedBox(height: 10,),
              ProductCard(product: Product.flutter,),
              SizedBox(height: 10,),
              ProductCard(product: Product.firebase,),

            ],
          ),
      )
    ),
  ));
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.image,
              width: 100,
            ),
            Text(product.title,
            style: TextStyle(
              fontSize: 35,
            ),
            ),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}