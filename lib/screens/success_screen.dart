import 'package:flutter/material.dart';
import 'package:eletro_store/screens/widgets/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: const Color(0xFF009688), size:120),
            SizedBox(height: 10),
            Text(
              'Purchase Completed Successfully!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.teal[800]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Your order has been processed and will be with you soon!',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            CustomButton(
              text: 'Back to Home',
              onPressed: () => Navigator.pushReplacementNamed(context, '/main'), // Changed to '/main' for consistency
            ),
          ],
        ),
      ),
    );
  }
}