import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paris/homeScreen.dart';
import 'package:paris/url.dart';

class Button extends StatefulWidget {
  final String textTitle;
  final VoidCallback onTap;

  Button({super.key, required this.textTitle, required this.onTap});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isTapped = false;

  void handleTap() async {
    setState(() {
      isTapped = true;
    });
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
      isTapped = false;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isTapped
              ? []
              : [
                  BoxShadow(
                    color: Color.fromARGB(180, 194, 0, 228),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(-4, -4),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.textTitle,
            style: TextStyle(
              fontSize: isTapped ? 15 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ),
      ),
    );
  }
}

void tempFunction(BuildContext context) {
  addOrder(context);
}

Future<void> addOrder(BuildContext context) async {
  final url = URL().baseURL + '/restaurant/add_orders';

  // Define the request body
  final Map<String, dynamic> requestBody = {
    "rest_id": selectedRestaurantId,
    "table_id": selectedTableId,
    "food_id": selectedFoodId,
    "food_count": 1 //orderCount
  };

  try {
    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      placeOrder(context, true);
      print("Order added successfully: ${response.body}");
    } else {
      placeOrder(context, false);
      print("Failed to add order. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}

void placeOrder(BuildContext context, bool status) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Order Placed'),
      content: status
          ? Text('The order is placed successfully... please wait')
          : Text('Something went wrong... please check with the counter'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

// Usage example in a widget

