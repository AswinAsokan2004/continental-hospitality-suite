import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paris/homeScreen.dart';
import 'package:paris/url.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginStatus = '';

  void _login() async {
    // Call the loginUser function with user input
    await loginUser(
        context, _usernameController.text, _passwordController.text);
  }

  Future<void> loginUser(
      BuildContext context, String bookingId, String customerName) async {
    final url = Uri.parse(URL().baseURL + '/app/customer_login');

    final body = jsonEncode({
      "booking_id": customerName,
      "customer_name": bookingId,
    });
    print(body);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        if (responseData['status'] == true) {
          // If status is true, navigate to HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          // If status is false, update the login status message
          setState(() {
            _loginStatus = 'Login failed: Invalid booking ID or customer name.';
          });
        }
      } else {
        // Handle any non-200 response
        setState(() {
          _loginStatus =
              'Error: ${response.statusCode} - ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      setState(() {
        _loginStatus = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'asset/paris_login_image.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Login UI
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To Paris',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    cursorColor: Colors.purple[700],
                    style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.purple[800],
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.purple[50],
                      prefixIcon: Icon(Icons.person, color: Colors.purple),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.purple[700]!, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    cursorColor: Colors.purple[700],
                    style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.purple[800],
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.purple[50],
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      suffixIcon:
                          Icon(Icons.visibility_off, color: Colors.purple[200]),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.purple[700]!, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Login Button
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Login status Text
                  Text(
                    _loginStatus,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paris"),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class CustomAppBarPage extends StatefulWidget {
  @override
  _CustomAppBarPageState createState() => _CustomAppBarPageState();
}

class _CustomAppBarPageState extends State<CustomAppBarPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AppBar(
            title: Text(
              "Paris",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade700,
                    Colors.purple.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.shade200.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Welcome to Paris!"),
      ),
    );
  }
}
