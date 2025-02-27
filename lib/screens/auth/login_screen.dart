import 'package:flutter/material.dart';
import 'package:eletro_store/screens/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.electrical_services, size: 80, color: Colors.teal[700]),
                  SizedBox(height: 16),
                  Text('Welcome to Eletro Store', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFEBEBEB),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.teal),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFEBEBEB),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.teal),
                    ),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?', style: TextStyle(color: Colors.teal)),
                    ),
                  ),
                  SizedBox(height: 32),
                  CustomButton(
                    text: 'Login',
                    onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomAuthButton(
                    text: 'Login with Google',
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    icon: Icon(Icons.g_mobiledata, color: Colors.red, size: 24),
                  ),
                  SizedBox(height: 10),
                  CustomAuthButton(
                    text: 'Login with Facebook',
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    icon: Icon(Icons.facebook, color: Color(0xFF3b5998), size: 24),
                  ),
                  SizedBox(height: 10),
                  CustomAuthButton(
                    text: 'Login with Apple',
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    icon: Icon(Icons.apple, color: Color(0xFF000000), size: 24),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account? ', style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/register'),
                        child: Text('Register', style: TextStyle(color: Colors.teal, fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
