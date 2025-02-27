import 'package:flutter/material.dart';
import 'package:eletro_store/screens/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.teal[800]!, Colors.teal[600]!], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.teal[100],
                        child: Icon(Icons.person, size: 50, color: Colors.teal[800]),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eletro User',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'user@eletrostore.com',
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit profile coming soon!')));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Order History',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (ctx, i) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.only(bottom: 12), // Should be 'bottom'
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: Icon(Icons.receipt_long, color: Colors.teal, size: 30),
                      title: Text(
                        'Order #00${i + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal[900]),
                      ),
                      subtitle: Text(
                        'Total: €${((i + 1) * 100).toStringAsFixed(2)}\n20/02/2025',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal, size: 16),
                      onTap: () {
                        Navigator.pushNamed(context, '/order-details', arguments: '00${i + 1}');
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(
                  text: 'Logout',
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}