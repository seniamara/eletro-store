import 'package:flutter/material.dart';
import 'package:eletro_store/models/product.dart';
import 'package:eletro_store/screens/product_card.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Product> mockProducts = [
    Product(
        id: '1',
        name: 'Smartphone X',
        price: 1299.00,
        image: 'assets/image/phone.jpeg',
        description: 'Modern Smartphone',
        weight: '',
        quality: ''),
    Product(
        id: '2',
        name: '50" LED TV',
        price: 2499.00,
        image: 'assets/image/tv.jpeg',
        description: 'High Definition TV',
        weight: '',
        quality: ''),
    Product(
        id: '3',
        name: 'Headphones',
        price: 199.00,
        image: 'assets/image/fone.jpeg',
        description: 'Crystal Clear Sound',
        weight: '',
        quality: ''),
    Product(
        id: '4',
        name: '50" LED TV',
        price: 2499.00,
        image: 'assets/image/liqui.jpeg',
        description: 'High Definition TV',
        weight: '',
        quality: ''),
  ];

  final List<String> categories = [
    'All',
    'Smartphones',
    'TVs',
    'Headphones',
    'Accessories'
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Store',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Icon(Icons.notifications, color: Colors.white),
          ],
        ),
        backgroundColor: Colors.teal[800],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your Items',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'New Arrivals for You',
                style: TextStyle(
                  color: Colors.teal[800],
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == index
                            ? Colors.teal[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategoryIndex == index
                              ? Colors.white
                              : Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mockProducts.length,
              itemBuilder: (ctx, i) => ProductCard(product: mockProducts[i]),
            ),
          ],
        ),
      ),
    );
  }
}
