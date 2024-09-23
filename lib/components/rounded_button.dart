import 'package:flutter/material.dart';

// Custom widget for a rounded button
class RoundedButton extends StatelessWidget {
  final Color colour; // Button color
  final String text; // Text displayed on the button
  final VoidCallback onPress; // Callback function when the button is pressed

  // Constructor to initialize the button properties
  const RoundedButton({
    super.key, // Key for the widget, passed to the superclass
    required this.colour, // Required color parameter
    required this.text, // Required text parameter
    required this.onPress, // Required onPress callback
  });

  @override
  Widget build(BuildContext context) {
    // Build method to create the widget UI
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0), // Vertical padding around the button
      child: Material(
        elevation: 5.0, // Shadow effect for elevation
        color: colour, // Button background color
        borderRadius: BorderRadius.circular(30.0), // Rounded corners
        child: MaterialButton(
          onPressed: onPress, // Call the onPress function when the button is pressed
          minWidth: 200.0, // Minimum width of the button
          height: 42.0, // Height of the button
          child: Text(
            text, // Display the button text
          ),
        ),
      ),
    );
  }
}
