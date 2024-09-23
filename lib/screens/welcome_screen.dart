import 'package:chat_app/screens/login_screen.dart'; // Import for login screen
import 'package:chat_app/screens/registration_screen.dart'; // Import for registration screen
import 'package:chat_app/components/rounded_button.dart'; // Import for custom rounded button widget
import 'package:flutter/material.dart'; // Import for Flutter UI components
import 'package:animated_text_kit/animated_text_kit.dart'; // Import for animated text kit

// Define WelcomeScreen widget, with a unique identifier for routing
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen'; // Unique ID used for navigation

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// Define the state for WelcomeScreen, which includes animations
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller; // Controls the animation
  late Animation animation; // Defines the animation itself

  // This method runs when the widget is first created
  @override
  void initState() {
    super.initState();

    // Initialize the animation controller (1 second duration, upperBound limits the value)
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 1), upperBound: 1.0);

    // Defines a curved animation, using the controller as the parent
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInCirc, // Sets a smooth easing curve for the animation
    );

    // Starts the animation going forward
    controller.forward();

    // Updates the UI every time the animation changes value
    controller.addListener(() {
      setState(() {}); // Rebuild the widget tree with updated animation values
    });
  }

  // Build method defines the UI layout of the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0), // Add horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets horizontally
          children: <Widget>[
            Row(
              children: <Widget>[
                // Hero widget for shared element animation (for transition to other screens)
                Hero(
                  tag: 'logo', // Unique tag for the logo animation
                  child: Container(
                    child: Image.asset('images/logo.png'), // App logo image
                    // The height of the logo is animated based on the animation value
                    height: animation.value * 100.0,
                  ),
                ),
                // Animated text with a typewriter effect
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Chat App", // Text to display
                      textStyle: TextStyle(
                        fontSize: 40.0, // Font size for the animated text
                        fontWeight: FontWeight.w900, // Bold font weight
                      ),
                    ),
                  ],
                  totalRepeatCount: 1, // Play the animation only once
                ),
              ],
            ),
            SizedBox(
              height: 48.0, // Add some vertical spacing between the logo/text and buttons
            ),
            // Custom RoundedButton widget for the "Log in" button
            RoundedButton(
                colour: Colors.lightBlue, // Button color
                text: "Log in", // Button label
                onPress: () {
                  // Navigate to the login screen when pressed
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            // Custom RoundedButton widget for the "Register" button
            RoundedButton(
                colour: Colors.blue, // Button color
                text: "Register", // Button label (fixed typo)
                onPress: () {
                  // Navigate to the registration screen when pressed
                  Navigator.pushNamed(context, RegistrationScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
