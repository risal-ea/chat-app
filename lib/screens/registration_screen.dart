import 'package:chat_app/constants.dart'; // Import for app constants
import 'package:chat_app/screens/chat_screen.dart'; // Import for the chat screen
import 'package:flutter/material.dart'; // Import for Flutter UI components
import 'package:chat_app/components/rounded_button.dart'; // Import for custom rounded button widget
import 'package:firebase_auth/firebase_auth.dart'; // Import for Firebase authentication
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Import for modal progress indicator

// Define RegistrationScreen widget with a unique identifier for routing
class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen'; // Unique ID used for navigation

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

// Define the state for RegistrationScreen
class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance; // Instance of FirebaseAuth for user authentication

  bool showSpinner = false; // Control for displaying the loading spinner
  String email = ''; // Variable to hold email input
  String password = ''; // Variable to hold password input

  // Build method defines the UI layout of the registration screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the screen
      body: ModalProgressHUD(
        inAsyncCall: showSpinner, // Show spinner based on showSpinner value
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Color of the spinner
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0), // Add horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets horizontally
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo', // Unique tag for hero animation
                  child: Container(
                    height: 200.0, // Height of the logo
                    child: Image.asset('images/logo.png'), // App logo image
                  ),
                ),
              ),
              SizedBox(
                height: 48.0, // Add vertical spacing
              ),
              // Email input field
              TextField(
                keyboardType: TextInputType.emailAddress, // Keyboard type for email input
                textAlign: TextAlign.center, // Center the text in the field
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
                onChanged: (value) {
                  email = value; // Update email variable with user input
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "Enter your email"), // Text field decoration
              ),
              SizedBox(
                height: 8.0, // Add vertical spacing
              ),
              // Password input field
              TextField(
                obscureText: true, // Hide password input
                textAlign: TextAlign.center, // Center the text in the field
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
                onChanged: (value) {
                  password = value; // Update password variable with user input
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"), // Text field decoration
              ),
              SizedBox(
                height: 24.0, // Add vertical spacing
              ),
              // Custom RoundedButton for registration
              RoundedButton(
                colour: Colors.blue, // Button color
                text: "Register", // Button label (fixed typo)
                onPress: () async {
                  print("email: $email , password: $password"); // Log email and password
                  setState(() {
                    showSpinner = true; // Show spinner when registration starts
                    print("showSpinner: $showSpinner");
                  });

                  try {
                    // Attempt to create a new user with email and password
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    // If user creation is successful, navigate to chat screen
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false; // Hide spinner after registration
                      print("showSpinner: $showSpinner");
                    });
                  } catch (e) {
                    // Catch and print any errors during registration
                    print("error from newUser: $e");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
