import 'package:flutter/material.dart';
import 'package:eletro_store/models/product.dart';
import 'package:eletro_store/models/cart_item.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<CartItem> orderItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'Smartphone X',
        price: 1299.99,
        image: 'assets/image/phone.jpeg',
        description: 'Modern Smartphone',
        weight: '150g',
        quality: 'High',
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        id: '3',
        name: 'Headphones',
        price: 199.99,
        image: 'assets/image/fone.jpeg',
        description: 'Crystal Clear Sound',
        weight: '50g',
        quality: 'Medium',
      ),
      quantity: 2,
    ),
  ];

  double get total => orderItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
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
                      Text(
                        'Order #${widget.orderId}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[800]),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.teal[700]!, Colors.teal[500]!]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: In Transit',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(Icons.local_shipping, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Order Items',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                ),
              ),
              ...orderItems.map((item) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(item.product.image, width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '€${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '€${(item.product.price * item.quantity).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal[700]),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                    ),
                    Text(
                      '€${total.toStringAsFixed(2)}', // Fixed currency to Euro
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Delivery',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                      ),
                      SizedBox(height: 8),
                      Text('Date: 28/02/2025', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      Text('Address: Rua 1, Cuca, Luanda', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}