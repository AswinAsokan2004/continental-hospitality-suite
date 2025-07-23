import 'package:flutter/material.dart';

class Buttom extends StatefulWidget {
  final String textTitle;
  final VoidCallback onTap;

  Buttom({super.key, required this.textTitle, required this.onTap});

  @override
  State<Buttom> createState() => _ButtomState();
}

class _ButtomState extends State<Buttom> {
  bool isTapped = false;

  void handleTap() async {
    setState(() {
      isTapped = true;
    });
    // Call the callback function passed from the parent widget
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
