import 'package:flutter/material.dart';

// Placeholder data model for a chat
class Chat {
  final String avatarUrl; // Or use placeholder icons
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted; // Added based on common WhatsApp features
  final bool isGroup; // To differentiate group icons if needed

  Chat({
    this.avatarUrl = '', // Default empty string
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isMuted = false,
    this.isGroup = false,
  });
}

// Placeholder chat data list
final List<Chat> dummyChats = [
  Chat(
    name: 'Reenu (You)',
    lastMessage: '✅✅ 2021 - AICTE Activity Point Progra...',
    timestamp: '06:01 PM', // Using the time from the image
    isPinned: true,
    // Use a local asset or placeholder icon if no URL
    avatarUrl: 'assets/reenu.png', // Example local asset path
  ),
  Chat(
    name: '8 SEM ISE',
    lastMessage: 'Muskan: Thank you sir',
    timestamp: '01:36 PM',
    unreadCount: 6,
    isPinned: true,
    isGroup: true,
    // avatarUrl: 'assets/ise_logo.png' // Example local asset path
  ),
  Chat(
    name: 'ISE 2025',
    lastMessage: 'Gururaj (PO): Policy Bazaar team wo...',
    timestamp: '01:19 PM',
    unreadCount: 3,
    isGroup: true,
    // avatarUrl: 'assets/group_icon.png' // Example local asset path
  ),
  Chat(
    name: 'Daddy',
    lastMessage: 'Waiting for this message. This may take...',
    timestamp: '12:28 PM',
    unreadCount: 1,
    // avatarUrl: 'assets/daddy_avatar.png' // Example local asset path
  ),
  Chat(
    name: '+91 79831 10682',
    lastMessage: '+91 79831 10682 turned off disappeari...',
    timestamp: '12:27 PM',
    unreadCount: 1,
    // Use a default avatar for numbers
  ),
  Chat(
    name: 'Ruhaan',
    lastMessage: '✓✓ Kab record kya woh',
    timestamp: '12:26 PM',
    // avatarUrl: 'assets/ruhaan_avatar.png' // Example local asset path
  ),
  Chat(
    name: 'Niha ✨', // Added emoji as in image
    lastMessage: 'Woich tohh',
    timestamp: '11:38 AM',
    unreadCount: 1,
    // avatarUrl: 'assets/niha_avatar.png' // Example local asset path
  ),
  Chat(
    name: 'Muskan Singh',
    lastMessage: 'Thank you 😊', // Added emoji
    timestamp: '10:07 AM',
    unreadCount:
        1, // Although image shows 0, the green circle usually means unread
    // avatarUrl: 'assets/muskan_avatar.png' // Example local asset path
  ),
  // Add more dummy chats as needed
];

void main() {
  runApp(ChatListApp());
}

class ChatListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        scaffoldBackgroundColor: Color(0xFF111B21), // WhatsApp dark background
        // Define other theme properties if needed
        appBarTheme: AppBarTheme(
          backgroundColor:
              Color(0xFF202C33), // Slightly lighter dark for AppBar
          elevation: 0, // No shadow
        ),
        listTileTheme: ListTileThemeData(
          // Setting default colors for list tiles if needed elsewhere
          textColor: Colors.white,
          iconColor: Colors.grey[400],
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[500]),
          // Define styles for the search TextField
        ),
        dividerColor: Colors.grey[800]?.withOpacity(0.5), // Color for dividers
      ),
      home: ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar to match the image structure more closely
      body: SafeArea(
        // Ensures content doesn't overlap status bar etc.
        child: Column(
          children: [
            // --- Header Section ---
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_square,
                            color: Colors.grey[400]), // Edit/New Chat Icon
                        tooltip: 'New Chat',
                        onPressed: () {/* Handle new chat action */},
                        splashRadius: 20,
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.filter_list,
                            color: Colors.grey[400]), // Filter/Menu Icon
                        tooltip: 'Filter chats',
                        onPressed: () {/* Handle filter action */},
                        splashRadius: 20,
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Search Bar ---
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF202C33), // Slightly lighter dark color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.grey[300]),
                  decoration: InputDecoration(
                    hintText: 'Search or start a new chat',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey[500], size: 20),
                    border: InputBorder.none, // Remove default border
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0), // Adjust padding
                  ),
                ),
              ),
            ),

            // --- Chat List ---
            Expanded(
              // Allows the ListView to take remaining space
              child: ListView.builder(
                itemCount: dummyChats.length,
                itemBuilder: (context, index) {
                  final chat = dummyChats[index];
                  return _ChatItem(chat: chat); // Use the helper widget
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for individual chat list items
class _ChatItem extends StatelessWidget {
  final Chat chat;

  const _ChatItem({required this.chat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[700], // Placeholder background
            // TODO: Replace with actual image loading (NetworkImage, AssetImage)
            // backgroundImage: chat.avatarUrl.isNotEmpty ? NetworkImage(chat.avatarUrl) : null,
            child: chat.avatarUrl.isEmpty
                ? Icon(
                    chat.isGroup ? Icons.group : Icons.person,
                    color: Colors.white70,
                    size: 28,
                  )
                : null, // Show icon only if no image URL
          ),
          title: Text(
            chat.name,
            style: TextStyle(
              color: Colors.grey[200],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            chat.lastMessage,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chat.timestamp,
                style: TextStyle(
                  fontSize: 12,
                  color: chat.unreadCount > 0
                      ? Color(0xFF00A884)
                      : Colors.grey[500], // WhatsApp green for unread time
                ),
              ),
              SizedBox(height: 5), // Spacing between time and badge/pin
              Row(
                mainAxisSize: MainAxisSize.min, // Take minimum space needed
                children: [
                  if (chat.isPinned)
                    Icon(Icons.push_pin, size: 16, color: Colors.grey[500]),
                  if (chat.isPinned && chat.unreadCount > 0)
                    SizedBox(width: 8), // Spacing between pin and badge
                  if (chat.unreadCount > 0)
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF00A884), // WhatsApp green color
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: TextStyle(
                          color: Color(0xFF111B21), // Dark text on green circle
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          onTap: () {
            // Handle chat item tap
            print('Tapped on ${chat.name}');
          },
        ),
        Divider(indent: 85, height: 0.5), // Indented divider like WhatsApp
      ],
    );
  }
}
