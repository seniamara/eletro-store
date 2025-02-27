import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> notifications = [
    {'title': 'Order Shipped', 'message': 'Your order #001 has been shipped!', 'time': 'Today, 14:30', 'icon': Icons.local_shipping},
    {'title': 'Active Promotion', 'message': 'Enjoy 20% off on electronics!', 'time': 'Yesterday, 09:15', 'icon': Icons.local_offer},
    {'title': 'Status Update', 'message': 'Your order #002 is in transit.', 'time': '25/02/2025, 16:00', 'icon': Icons.update},
  ];

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.teal[900], size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[800]),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: notifications.length,
                  itemBuilder: (ctx, i) {
                    final notification = notifications[i];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(bottom: 8), // Should be 'bottom'
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[100],
                            child: Icon(notification['icon'], color: Colors.teal[800]),
                          ),
                          title: Text(
                            notification['title'],
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal[900]),
                          ),
                          subtitle: Text(
                            '${notification['message']}\n${notification['time']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          onTap: () {
                            if (notification['title'].contains('Order')) {
                              Navigator.pushNamed(context, '/order-details', arguments: '00${i + 1}');
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}