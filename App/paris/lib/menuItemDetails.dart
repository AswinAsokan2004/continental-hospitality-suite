import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:paris/button.dart';
import 'package:paris/homeScreen.dart';
import 'package:paris/url.dart';

class MenuItemDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> menuItem;

  MenuItemDetailsScreen({
    required this.menuItem,
  });

  @override
  _MenuItemDetailsScreenState createState() => _MenuItemDetailsScreenState();
}

class _MenuItemDetailsScreenState extends State<MenuItemDetailsScreen> {
  int orderCount = 1; // Order count as a local state variable

  void incrementOrder() {
    setState(() {
      orderCount++;
    });
  }

  void decrementOrder() {
    setState(() {
      if (orderCount > 1) orderCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem['name']),
        backgroundColor: const Color.fromARGB(255, 251, 101, 56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.menuItem['name'],
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                buildDetailRow(Icons.attach_money, "Price",
                    "\₹${widget.menuItem['price']}"),
                buildDetailRow(
                    Icons.restaurant_menu, "Type", widget.menuItem['type']),
                buildDetailRow(
                  Icons.eco,
                  "Is Veg",
                  widget.menuItem['isVeg'] == 1 ? 'Yes' : 'No',
                  valueColor:
                      widget.menuItem['isVeg'] == 1 ? Colors.green : Colors.red,
                ),
                SizedBox(height: 20),

                // Order Counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      onPressed: decrementOrder,
                    ),
                    Text(
                      orderCount.toString(),
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 50.0,
                      ),
                      onPressed: incrementOrder,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Order Count',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                SizedBox(height: 20),

                // Place Order Button
                Center(
                  child: Button(
                    textTitle: 'Place Order',
                    onTap: () => tempFunction(context),
                  ),
                  // child: ElevatedButton(
                  //   onPressed: () =>
                  //       addOrder(context), // Updated onPressed callback
                  //   style: ElevatedButton.styleFrom(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  //     backgroundColor: Colors.deepOrangeAccent,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Place Order',
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrangeAccent),
          SizedBox(width: 12),
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void tempFuntion(context) {
    addOrder(context);
  }

  Future<void> addOrder(BuildContext context) async {
    final url = URL().baseURL + '/restaurant/add_orders';

    // Define the request body
    final Map<String, dynamic> requestBody = {
      "rest_id": selectedRestaurantId,
      "table_id": selectedTableId,
      "food_id": selectedFoodId,
      "food_count": orderCount
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
}
