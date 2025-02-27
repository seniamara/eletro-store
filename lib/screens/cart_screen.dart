import 'package:flutter/material.dart';
import 'package:eletro_store/models/cart_item.dart';
import 'package:eletro_store/models/product.dart';
import 'package:eletro_store/screens/widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  final List<CartItem> mockCartItems = [
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
      quantity: 1,
    ),
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementQuantity(int index) {
    setState(() {
      mockCartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (mockCartItems[index].quantity > 0) mockCartItems[index].quantity--;
    });
  }

  double _calculateTotal() {
    return mockCartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mockCartItems.length,
                itemBuilder: (ctx, i) {
                  final item = mockCartItems[i];
                  return Dismissible(
                    key: Key(item.product.id),
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      setState(() {
                        mockCartItems.removeAt(i);
                      });
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.product.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
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
                                    '€${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14, color: Colors.teal[700]),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle, color: Colors.teal[800], size: 24),
                                  onPressed: () => _decrementQuantity(i),
                                ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                                  child: Text(
                                    '${item.quantity}',
                                    key: ValueKey(item.quantity),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle, color: Colors.teal[800], size: 24),
                                  onPressed: () => _incrementQuantity(i),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: Offset(0, -5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                  ),
                  SizedBox(height: 12),
                  ...mockCartItems.map((item) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.product.name} (${item.quantity}x)',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              '€${(item.product.price * item.quantity).toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 14, color: Colors.teal[700]),
                            ),
                          ],
                        ),
                      )),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                      ),
                      Text(
                        '€${_calculateTotal().toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invoice printed!')));
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.teal[700],
                            side: BorderSide(color: Colors.teal[700]!),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text('Print Invoice', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Checkout',
                          onPressed: mockCartItems.isEmpty ? null : () => Navigator.pushNamed(context, '/checkout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}