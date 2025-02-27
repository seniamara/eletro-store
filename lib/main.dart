import 'package:flutter/material.dart';
import 'package:eletro_store/screens/auth/login_screen.dart';
import 'package:eletro_store/screens/auth/register_screen.dart';
import 'package:eletro_store/screens/auth/splashScreen.dart';
import 'package:eletro_store/screens/cart_screen.dart';
import 'package:eletro_store/screens/checkout_screen.dart';
import 'package:eletro_store/screens/main_screen.dart';
import 'package:eletro_store/screens/notificationsScreen.dart';
import 'package:eletro_store/screens/orderDetails_screen.dart';
import 'package:eletro_store/screens/product_detail_screen.dart';
import 'package:eletro_store/screens/profile_screen.dart';
import 'package:eletro_store/screens/storescreen.dart';
import 'package:eletro_store/screens/success_screen.dart';
import 'package:eletro_store/models/product.dart';
import 'package:eletro_store/screens/support.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eletro Store',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[900]),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.teal, width: 2)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        '/login': (ctx) => LoginScreen(),
        '/register': (ctx) => RegisterScreen(),
        '/main': (ctx) => MainScreen(),
        '/store': (ctx) => StoreScreen(),
        '/cart': (ctx) => CartScreen(),
        '/checkout': (ctx) => CheckoutScreen(),
        '/success': (ctx) => SuccessScreen(),
        '/profile': (ctx) => ProfileScreen(),
        '/support': (ctx) => CustomerSupportScreen(),
        '/notifications': (ctx) => NotificationsScreen(),
        '/order-details': (ctx) => OrderDetailsScreen(
              orderId: ModalRoute.of(ctx)!.settings.arguments as String,
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product-detail') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product));
        }
        return null;
      },
    );
  }
}