import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:eletro_store/models/product.dart';
import 'package:eletro_store/screens/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final List<Product> mockProducts = [
    Product(id: '1', name: 'Smartphone X', price: 1299.00, image: 'assets/image/phone.jpeg', description: 'Modern Smartphone', weight: '', quality: ''),
    Product(id: '2', name: '50" LED TV', price: 2499.00, image: 'assets/image/tv.jpeg', description: 'High Definition TV', weight: '', quality: ''),
    Product(id: '3', name: 'Headphones', price: 199.00, image: 'assets/image/fone.jpeg', description: 'Crystal Clear Sound', weight: '', quality: ''),
    Product(id: '4', name: '50" LED TV', price: 2499.00, image: 'assets/image/liqui.jpeg', description: 'High Definition TV', weight: '', quality: ''),
  ];

  final List<Map<String, String>> carouselItems = [
    {'title': 'Unmissable Offers!', 'subtitle': 'Up to 50% Off', 'image': 'assets/image/phone.jpeg'},
    {'title': 'New Smartphones', 'subtitle': 'Cutting-Edge Technology', 'image': 'assets/image/tv.jpeg'},
    {'title': 'Premium Audio', 'subtitle': 'Immersive Sound', 'image': 'assets/image/fone.jpeg'},
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Eletro Store', style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                      icon: Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Products...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                        ),
                        onSubmitted: (value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Searching: $value'))),
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Promotions',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                      ),
                    ),
                    SizedBox(height: 8),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.9,
                      ),
                      items: carouselItems.map((item) => Container(
                        width: 350,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF009688),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(item['image']!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item['title']!, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 8),
                            Text(item['subtitle']!, style: TextStyle(fontSize: 16, color: Colors.white70)),
                          ],
                        ),
                      )).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Featured Products',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.teal[900], fontWeight: FontWeight.bold),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: mockProducts.length,
                        itemBuilder: (ctx, i) => ProductCard(product: mockProducts[i]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}