import 'package:flutter/material.dart'; // Import Flutter UI components
import 'package:chat_app/constants.dart'; // Import app constants
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore database

// Initialize Firestore and declare a variable for the logged-in user
final _firestore = FirebaseFirestore.instance;
User? loggedInUser; // Nullable variable to hold the currently logged-in user

// Define ChatScreen widget with a unique identifier for routing
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen'; // Unique ID used for navigation

  @override
  _ChatScreenState createState() => _ChatScreenState(); // Create state for ChatScreen
}

// Define the state for ChatScreen
class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController(); // Controller for the message input field
  final _auth = FirebaseAuth.instance; // Instance of FirebaseAuth for user authentication
  String messageText = ''; // Variable to hold the current message text
  final ScrollController _scrollController = ScrollController(); // Controller for scrolling the message list

  @override
  void initState() {
    getCurrentUser(); // Call to get the current user when the widget is initialized
    super.initState();
  }

  void getCurrentUser() async {
    // Function to get the currently logged-in user
    try {
      final user = await _auth.currentUser; // Get the current user from Firebase
      if (user != null) {
        loggedInUser = user; // Set the logged-in user variable
      }
    } catch (e) {
      print(e); // Print any errors
    }
  }

  void scrollToBottom() {
    // Automatically scroll to the bottom when a new message arrives
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // Scroll to the bottom
        duration: Duration(milliseconds: 300), // Animation duration
        curve: Curves.easeOut, // Animation curve
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build method defines the UI layout of the chat screen
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the screen
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close), // Close icon for the app bar
              onPressed: () {
                _auth.signOut(); // Sign out the user
                Navigator.pop(context); // Navigate back to the previous screen
              }),
        ],
        title: Text('⚡️Chat'), // Title of the app bar
        backgroundColor: Colors.lightBlueAccent, // App bar background color
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out widgets vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets horizontally
          children: <Widget>[
            MessagesStream(), // Stream of messages displayed in the chat
            Container(
              decoration: kMessageContainerDecoration, // Container decoration for the message input area
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController, // Controller for the input field
                      onChanged: (value) {
                        messageText = value; // Update messageText with user input
                      },
                      decoration: kMessageTextFieldDecoration, // Decoration for the text field
                      style: TextStyle(color: Colors.black), // Text style
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear(); // Clear the input field
                      _firestore.collection('messages').add({ // Add message to Firestore
                        'text': messageText, // Message text
                        'sender': loggedInUser?.email, // Sender's email
                        'timestamp': FieldValue.serverTimestamp() // Timestamp for the message
                      });
                      scrollToBottom(); // Scroll to the bottom after sending
                    },
                    child: Text(
                      'Send', // Button label
                      style: kSendButtonTextStyle, // Text style for the button
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define a widget to display the stream of messages
class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore // Create a stream of messages from Firestore
          .collection('messages')
          .orderBy('timestamp', descending: false) // Order messages by timestamp
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Show loading indicator while waiting for data
          );
        }

        // Handle error cases
        if (snapshot.hasError) {
          return Center(
            child: Text('Error loading messages'), // Show error message if loading fails
          );
        }

        if (snapshot.hasData) {
          final messages = snapshot.data?.docs; // Get the list of messages
          List<MessageBubble> messageBubbles = []; // List to hold message bubbles

          for (var message in messages!) {
            final messageText = message['text']; // Get message text
            final messageSender = message['sender']; // Get sender's email

            final currentUser = loggedInUser?.email; // Get the current user's email

            // Create MessageBubble for each message
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender, // Check if the message was sent by the current user
            );
            messageBubbles.add(messageBubble); // Add message bubble to the list
          }

          // Display the list of message bubbles in a ListView
          return Expanded(
            child: ListView(
              controller: ScrollController(), // Controller for the ListView
              reverse: true, // Reverse the order of messages
              children: messageBubbles.reversed.toList(), // Show messages in reverse order
            ),
          );
        }

        // Fallback if no data is available
        return Center(
          child: Text('No messages to display'), // Show message if there are no messages
        );
      },
    );
  }
}

// Define a widget to display individual message bubbles
class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
        required this.sender,
        required this.text,
        required this.isMe});

  final String sender; // Sender's email
  final String text; // Message text
  final bool isMe; // Flag to check if the message is sent by the current user

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Padding around the message bubble
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, // Align bubble based on sender
        children: <Widget>[
          Text(
            sender, // Display sender's email
            style: TextStyle(color: Colors.black54), // Text style
          ),
          Material(
            borderRadius: isMe // Conditional border radius for the message bubble
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30))
                : BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
            elevation: 5.0, // Shadow effect for the bubble
            color: isMe ? Colors.lightBlueAccent : Colors.white, // Conditional background color
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding for the text
              child: Text(
                text, // Display the message text
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 20.0), // Text color and size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
