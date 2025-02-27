import 'package:flutter/material.dart';
import 'package:eletro_store/screens/widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController();
  static const String currencySymbol = '€';

  @override
  void initState() {
    super.initState();
    _addressController.text = 'Rua 1, Luiz, São Paulo, LDA';
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.teal[900], size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Checkout',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[900]),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Your Address',
                  prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage("assets/image/Map.jpg"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location updated!')));
                        },
                        icon: Icon(Icons.my_location, size: 18),
                        label: Text('Use Current Location', style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Total: $currencySymbol${1499.97}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.teal[700]),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Complete Purchase',
                  onPressed: () => Navigator.pushReplacementNamed(context, '/success'),
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