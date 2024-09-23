import 'package:flutter/material.dart';

// Style for the send button text
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent, // Text color for the button
  fontWeight: FontWeight.bold, // Bold font weight
  fontSize: 22.0, // Font size
);

// Decoration for the message text input field
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0), // Padding inside the text field
  hintText: 'Type your message here...', // Placeholder text
  border: InputBorder.none, // No border for the text field
);

// Decoration for the message container (the area where messages are typed)
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0), // Top border styling
  ),
);

// General decoration for text fields (used in registration and login screens)
const kTextFieldDecoration = InputDecoration(
  hintText: "null", // Placeholder text; can be updated based on context
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding inside the text field
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)), // Rounded corners
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0), // Border when the field is enabled
    borderRadius: BorderRadius.all(Radius.circular(32.0)), // Rounded corners
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0), // Border when the field is focused
    borderRadius: BorderRadius.all(Radius.circular(32.0)), // Rounded corners
  ),
);
