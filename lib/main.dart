import 'package:flutter/material.dart'; // Flutter package for UI components
import 'package:chat_app/screens/welcome_screen.dart'; // Custom welcome screen
import 'package:chat_app/screens/login_screen.dart'; // Custom login screen
import 'package:chat_app/screens/registration_screen.dart'; // Custom registration screen
import 'package:chat_app/screens/chat_screen.dart'; // Custom chat screen
import 'package:firebase_core/firebase_core.dart'; // Firebase initialization package

// Main entry point of the application
void main() async {
  // Ensures that widget binding happens before initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase before running the app
  await Firebase.initializeApp(); // Initialize Firebase

  // Runs the app by calling the FlashChat widget
  runApp(FlashChat());
}

// Main app widget
class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      // Define the overall theme of the app (using dark theme here)
      theme: ThemeData.dark().copyWith(
        // Customize the default text theme for the app
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54), // Set default text color
        ),
      ),

      // Set the initial screen that appears when the app launches
      initialRoute: WelcomeScreen.id,

      // Define the routes for navigation in the app
      routes: {
        // When the route is WelcomeScreen, load WelcomeScreen widget
        WelcomeScreen.id : (context) => WelcomeScreen(),

        // When the route is LoginScreen, load LoginScreen widget
        LoginScreen.id : (context) => LoginScreen(),

        // When the route is RegistrationScreen, load RegistrationScreen widget
        RegistrationScreen.id : (context) => RegistrationScreen(),

        // When the route is ChatScreen, load ChatScreen widget
        ChatScreen.id : (context) => ChatScreen(),
      },
    );
  }
}
