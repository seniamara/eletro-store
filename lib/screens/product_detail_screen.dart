import 'package:flutter/material.dart';
import 'package:eletro_store/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  int cartQuantity = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isFavorite ? 'Added to Favorites!' : 'Removed from Favorites')),
      );
    });
  }

  void _addToCart() {
    setState(() {
      cartQuantity++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.name} added to cart!')),
    );
  }

  void _removeFromCart() {
    setState(() {
      if (cartQuantity > 0) cartQuantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[50]!, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.teal[900], size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: AnimatedScale(
                            scale: isFavorite ? 1.2 : 1.0,
                            duration: Duration(milliseconds: 200),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.teal[900],
                              size: 30,
                            ),
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: widget.product.id,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.product.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), // Should be 'bottom'
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle, color: Colors.teal[800], size: 30),
                                onPressed: _removeFromCart,
                              ),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 200),
                                child: Text(
                                  '$cartQuantity',
                                  key: ValueKey(cartQuantity),
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle, color: Colors.teal[800], size: 30),
                                onPressed: _addToCart,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '€${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24, color: Colors.teal[700], fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                      Text(
                        widget.product.description,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text('Weight: ${widget.product.weight}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                          SizedBox(width: 20),
                          Text('Quality: ${widget.product.quality}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[900])),
                            SizedBox(height: 8),
                            Text('• Advanced Technology', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                            Text('• Ergonomic Design', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                            Text('• 1-Year Warranty', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cartQuantity > 0 ? _addToCart : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}