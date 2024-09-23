import 'package:chat_app/screens/chat_screen.dart'; // Import for the chat screen
import 'package:flutter/material.dart'; // Import for Flutter UI components
import 'package:chat_app/components/rounded_button.dart'; // Import for custom rounded button widget
import 'package:chat_app/constants.dart'; // Import for app constants
import 'package:firebase_auth/firebase_auth.dart'; // Import for Firebase authentication
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Import for modal progress indicator

// Define LoginScreen widget with a unique identifier for routing
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen'; // Unique ID used for navigation

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// Define the state for LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance; // Instance of FirebaseAuth for user authentication

  bool showSpinner = false; // Control for displaying the loading spinner
  String email = ''; // Variable to hold email input
  String password = ''; // Variable to hold password input

  // Build method defines the UI layout of the login screen
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
              // Hero widget for shared element animation (for transition to other screens)
              Hero(
                tag: 'logo', // Unique tag for the logo animation
                child: Container(
                  height: 200.0, // Height of the logo
                  child: Image.asset('images/logo.png'), // App logo image
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
              // Custom RoundedButton for login
              RoundedButton(
                  colour: Colors.lightBlue, // Button color
                  text: "log in", // Button label
                  onPress: () async {
                    print("email: $email password: $password"); // Log email and password
                    setState(() {
                      showSpinner = true; // Show spinner when login starts
                    });
                    try {
                      // Attempt to sign in with email and password
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      // If user authentication is successful, navigate to chat screen
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false; // Hide spinner after login
                      });
                    } catch (e) {
                      // Catch and print any errors during login
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
