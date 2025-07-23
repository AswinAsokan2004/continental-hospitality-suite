import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:paris/maintenanceRequirements.dart';
import 'package:paris/menuItemDetails.dart';
import 'package:paris/url.dart';

final listOfScreens = <Widget>[MenuListScreen(), RoomSelectionScreen()];
bool isRestaurant = true;
final ScreenIcons = <Widget>[
  const Icon(Icons.menu),
  const Icon(Icons.clean_hands),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 102, 102),
      appBar: AppBar(
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
      body: Stack(
        children: [
          listOfScreens[index],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          //backgroundColor: Color.fromARGB(255, 184, 184, 184),
          color: index == 0
              ? Color.fromARGB(255, 184, 184, 184)
              : Color.fromARGB(255, 212, 242, 239),
          items: ScreenIcons,
          height: 50,
          buttonBackgroundColor: const Color.fromARGB(255, 249, 176, 176),
          backgroundColor: Color.fromARGB(255, 171, 8, 133),
          index: index,
          onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex; // Update index to show selected screen
            });
          }),
    );
  }
}

class MenuListScreen extends StatefulWidget {
  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

int? selectedRestaurantId;
int? selectedTableId;
int? selectedFoodId;

class _MenuListScreenState extends State<MenuListScreen> {
  List<int> restaurantIds = [];
  List<dynamic> tableIds = [];
  List<dynamic> menuItems = [];

  @override
  void initState() {
    super.initState();
    fetchRestaurantIds();
  }

  // Fetch Restaurant IDs
  Future<void> fetchRestaurantIds() async {
    final url = Uri.parse(URL().baseURL + '/restaurant/restaurant_id');

    try {
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print(response.body);
        final responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            restaurantIds = responseData
                .map<int>((item) => item['rest_id'] as int)
                .toList();
          });
          print("Fetched restaurant IDs: $restaurantIds");
        } else {
          print("Unexpected response format: $responseData");
        }
      } else {
        print('Failed to fetch restaurant IDs: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching restaurant IDs: $e');
    }
  }

  // Fetch Table IDs based on selected Restaurant ID
  Future<void> fetchTableIds(int restId) async {
    final url =
        Uri.parse(URL().baseURL + '/restaurant/fetch_selected_restaurant');
    final body = jsonEncode({"rest_id": restId});

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(
            'Table IDs response: $responseData'); // Log the response to check the structure
        setState(() {
          tableIds = responseData['table_details'];
          selectedTableId =
              null; // Reset table selection when restaurant changes
        });
        print("Fetched table IDs: $tableIds");
      } else {
        print('Failed to fetch table IDs: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching table IDs: $e');
    }
  }

  // Fetch menu details based on selected restaurant and table
  Future<void> fetchMenuDetails(int restId) async {
    final url =
        Uri.parse(URL().baseURL + '/restaurant/fetch_selected_restaurant');
    final body = jsonEncode({"rest_id": restId});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          menuItems = responseData['menu_details'];
        });
      } else {
        print('Failed to fetch menu details: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching menu details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 184, 184),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for Restaurant IDs
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.purple[100], // Light purple background
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                border: Border.all(
                    color: Colors.purple, width: 2.0), // Border color and width
              ),
              child: DropdownButton<int>(
                hint: Text(
                  "Select Restaurant ID",
                  style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold), // Hint text color
                ),
                value: selectedRestaurantId,
                dropdownColor:
                    Colors.purple[50], // Dropdown menu background color
                icon: Icon(Icons.arrow_drop_down,
                    color: Colors.purple), // Dropdown icon color
                items: restaurantIds.map((id) {
                  return DropdownMenuItem<int>(
                    value: id,
                    child: Text(
                      "Restaurant ID: $id",
                      style: TextStyle(
                          color: Colors.purple[900]), // Item text color
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRestaurantId = value;
                    selectedTableId = null; // Reset table selection
                    tableIds.clear(); // Clear previous table IDs
                    menuItems.clear(); // Clear previous menu items
                  });
                  if (value != null) {
                    fetchTableIds(value);
                    menuItems.clear();
                    // fetchMenuDetails(selectedRestaurantId!); // Fetch table IDs for selected restaurant
                  }
                },
                underline: Container(), // Remove default underline
              ),
            ),

            SizedBox(height: 20),

            // Dropdown for Table IDs
            if (selectedRestaurantId != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  color: Colors.purple[
                      100], // Light purple background for dropdown container
                  borderRadius: BorderRadius.circular(
                      8.0), // Rounded corners for modern design
                  border: Border.all(
                      color: Colors.purple, width: 2.0), // Purple border
                ),
                child: DropdownButton<int>(
                  hint: Text(
                    "Select Table ID",
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontWeight: FontWeight.bold), // Hint text color
                  ),
                  value: selectedTableId,
                  dropdownColor: Colors
                      .purple[50], // Light purple dropdown menu background
                  icon: Icon(Icons.arrow_drop_down,
                      color: Colors.purple), // Dropdown icon color
                  items: tableIds.map((id) {
                    return DropdownMenuItem<int>(
                      value: id['table_id'],
                      child: Text(
                        "Table ID: ${id['table_id']}",
                        style: TextStyle(
                            color: Colors.purple[900]), // Item text color
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTableId = value;
                      menuItems.clear(); // Clear previous menu items
                    });
                    if (value != null) {
                      fetchMenuDetails(
                          selectedRestaurantId!); // Fetch menu details for selected table
                    }
                  },
                  underline: Container(), // Remove default underline
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: menuItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Select a restaurant and table to view menu',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey), // Hint styling
                      ),
                    )
                  : ListView.builder(
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return Card(
                          elevation: 4.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          shadowColor: Colors.purple[200],
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12.0),
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[900], // Title color
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price: \₹${item['price']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87, // Price color
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          4.0), // Space between subtitle items
                                  Text(
                                    "Type: ${item['type']}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: item["isVeg"] == 1
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                item['isVeg'] == 1 ? 'Veg' : 'Non-Veg',
                                style: TextStyle(
                                  color: item["isVeg"] == 1
                                      ? Colors.green[900]
                                      : Colors.red[900],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              // Navigate to details screen on tap
                              setState(() {
                                selectedFoodId = item['food_id'];
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MenuItemDetailsScreen(menuItem: item),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            // Menu Details List
            // Expanded(
            //   child: menuItems.isEmpty
            //       ? const Center(
            //           child: Text('Select a restaurant and table to view menu'))
            //       : ListView.builder(
            //           itemCount: menuItems.length,
            //           itemBuilder: (context, index) {
            //             final item = menuItems[index];
            //             return Card(
            //               margin: EdgeInsets.all(8.0),
            //               child: ListTile(
            //                 title: Text(item['name'],
            //                     style: TextStyle(
            //                         fontSize: 18, fontWeight: FontWeight.bold)),
            //                 subtitle: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text("Price: \$${item['price']}"),
            //                     Text("Type: ${item['type']}"),
            //                   ],
            //                 ),
            //                 trailing: Text(
            //                     "${item['isVeg'] == 1 ? 'Veg' : 'Non-Veg'}",
            //                     style: TextStyle(
            //                         color: item["isVeg"] == 1
            //                             ? Colors.green
            //                             : Colors.red)),
            //                 onTap: () {
            //                   // Navigate to details screen on tap
            //                   setState(() {
            //                     selectedFoodId = item['food_id'];
            //                     print('7587566587 $selectedFoodId');
            //                   });
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (context) =>
            //                           MenuItemDetailsScreen(menuItem: item),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             );
            //           },
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
