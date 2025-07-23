import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paris/button1.dart';
import 'package:paris/url.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  List<String> roomIds = [];
  String? selectedRoomId;
  bool isLoading = true; // Loading state
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController longTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRoomIds();
  }

  // Fetch room IDs from the API
  Future<void> fetchRoomIds() async {
    final url = URL().baseURL + '/app/fetch_all_rooms';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['room_id'] != null) {
          final List<dynamic> roomData = data['room_id'];

          // Update state with fetched room IDs
          setState(() {
            roomIds =
                roomData.map((room) => room['room_id'] as String).toList();
            isLoading = false; // Set loading to false after data is fetched
          });
        } else {
          print("Error: 'room_id' key not found in response.");
        }
      } else {
        print("Failed to load room IDs. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching room IDs: $e");
    }
  }

  // Show submission confirmation dialog
  Future<void> submitMaintenanceRequest() async {
    final url = URL().baseURL + '/maintenance/add_requirements';

    // Define the request body
    final Map<String, dynamic> requestBody = {
      "user_id": textFieldController.text,
      "isCustomer": true,
      "room_id": selectedRoomId,
      "description": longTextController.text,
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

      // Check the response status and show appropriate message
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String status = responseData['status'] ?? 'Unknown status';

        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Request Submitted'),
            content: Text('Your request status: $status'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  textFieldController.clear();
                  longTextController.clear();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print("Failed to submit request. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while submitting maintenance request: $e");
    }
  }

  // Handle form submission
  void handleSubmit() {
    // Add your submission logic here
    // For demonstration, we're simply showing the dialog
    submitMaintenanceRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 242, 239),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 212, 242, 239),
        title: Text(
          'Place The Requirement',
          style: TextStyle(fontSize: 17, color: Colors.purple),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for selecting room ID
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 12.0),
                          filled: true,
                          fillColor: Colors
                              .purple[50], // Light purple background color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none, // Remove border line
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.purple,
                                width: 2.0), // Enabled border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.purple[700]!,
                                width: 2.0), // Focused border color
                          ),
                          hintStyle: TextStyle(
                              color: Colors.purple[800],
                              fontWeight: FontWeight.bold),
                        ),
                        hint: Text(
                          "Select Room ID",
                          style: TextStyle(
                              color: Colors.purple[900],
                              fontWeight: FontWeight.bold),
                        ),
                        value: selectedRoomId,
                        dropdownColor:
                            Colors.purple[50], // Dropdown menu background color
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.purple), // Dropdown icon color
                        items: roomIds.map((roomId) {
                          return DropdownMenuItem(
                            value: roomId,
                            child: Text(
                              roomId,
                              style: TextStyle(
                                  color:
                                      Colors.purple[900]), // Room ID text color
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRoomId = value;
                          });
                        },
                      ),
                // : DropdownButtonFormField<String>(
                //     value: selectedRoomId,
                //     hint: Text("Select Room ID"),
                //     items: roomIds.map((roomId) {
                //       return DropdownMenuItem(
                //         value: roomId,
                //         child: Text(roomId),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         selectedRoomId = value;
                //       });
                //     },
                //   ),
                SizedBox(height: 20),

                // Regular TextField
                TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    labelText: 'Enter User Name',
                    labelStyle: TextStyle(
                        color: Colors.purple[900], fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.purple[50], // Light purple background
                    prefixIcon: Icon(Icons.person,
                        color: Colors.purple), // Icon for user input
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                      borderSide: BorderSide.none, // Remove default border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Colors.purple,
                          width: 1.5), // Enabled border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Colors.purple[700]!,
                          width: 2.0), // Focused border color
                    ),
                    hintText: 'User Name',
                    hintStyle: TextStyle(color: Colors.purple[300]),
                  ),
                  style: TextStyle(
                      color: Colors.purple[900]), // Text color in purple
                  cursorColor: Colors.purple[700], // Cursor color
                ),
                SizedBox(height: 20),

                // Long TextFormField
                TextFormField(
                  controller: longTextController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Enter Detailed Information',
                    labelStyle: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    filled: true,
                    fillColor: Colors.purple[
                        50], // Light purple background for a distinct look
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0), // Extra padding
                    alignLabelWithHint: true, // Align label for multiline input
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Rounded corners for a soft look
                      borderSide: BorderSide.none, // Removes default border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Colors.purple,
                          width: 1.5), // Purple border when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Colors.purple[700]!,
                          width: 2.0), // Darker purple border when focused
                    ),
                    hintText: 'Enter additional details here...',
                    hintStyle:
                        TextStyle(color: Colors.purple[300], fontSize: 14.0),
                  ),
                  style: TextStyle(
                      color: Colors.purple[900],
                      fontSize: 16.0), // Text color in purple
                  cursorColor: Colors.purple[700], // Purple cursor color
                ),
                SizedBox(height: 30),

                // Submit Button
                Center(child: Buttom(textTitle: "Submit", onTap: handleSubmit)
                    // child: ElevatedButton(
                    //   onPressed: handleSubmit,
                    //   style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    //     backgroundColor: Colors.deepOrangeAccent,
                    //   ),
                    //   child: Text(
                    //     'Submit',
                    //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
}
