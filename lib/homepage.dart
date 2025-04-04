import 'package:flutter/material.dart';

// --- Data Model (from Chat List code) ---
class Chat {
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted; // Added based on common WhatsApp features
  final bool isGroup; // To differentiate group icons if needed

  Chat({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isMuted = false,
    this.isGroup = false,
  });
}

// --- Dummy Data (from Chat List code) ---
final List<Chat> dummyChats = [
  Chat(
    name: 'Fahad',
    lastMessage: 'So beautiful, so elegant',
    timestamp: '06:02 pm',
    unreadCount: 1,
  ),
  Chat(
    name: 'Reenu (You)',
    lastMessage: 'Hello',
    timestamp: '06:01 PM',
  ),
  Chat(
    name: '8 SEM ISE',
    lastMessage: 'Muskan: Thank you sir',
    timestamp: '01:36 PM',
    unreadCount: 6,
    isGroup: true,
  ),
  Chat(
    name: 'Friends forever lol',
    lastMessage: 'Riya: Lets meet 6pm. shrap',
    timestamp: '01:19 PM',
    unreadCount: 3,
    isGroup: true,
  ),
  Chat(
    name: 'Daddy',
    lastMessage: 'Waiting for this message. This may take...',
    timestamp: '12:28 PM',
    unreadCount: 1,
  ),
  Chat(
    name: '+91 79831 10682',
    lastMessage: '+91 79831 10682 turned off disappeari...',
    timestamp: '12:27 PM',
    unreadCount: 1,
  ),
  Chat(
    name: 'Unknown',
    lastMessage: 'May I know you??',
    timestamp: '12:26 PM',
  ),
  Chat(
    name: 'Niha ✨',
    lastMessage: 'Hello lady',
    timestamp: '11:38 AM',
    unreadCount: 1,
  ),
  Chat(
    name: 'Muskan Singh',
    lastMessage: 'Thank you 😊',
    timestamp: '10:07 AM',
    unreadCount: 1,
  ),
];

// --- Main App Setup ---
void main() {
  runApp(Homepage());
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.white.withOpacity(0.15), // Divider color
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00A884), // WhatsApp green accent
          secondary: Color(0xFF005D4B), // Darker green shade
          surface: Color(0xFF202C33), // Color for cards, search bar bg
          onSurface: Colors.grey[300]!, // Text color on surface elements
        ),
        iconTheme: IconThemeData(color: Colors.grey[400]), // Default icon color
        listTileTheme: ListTileThemeData(
          iconColor: Colors.grey[400],
          textColor: Colors.grey[200], // Default text color for list tiles
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: Colors.grey[500],
        ),
        tooltipTheme: TooltipThemeData(
          textStyle: TextStyle(color: Colors.white),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      home: MainScreen(),
    );
  }
}

// --- Main Screen combining Sidebar and Chat List ---
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
      ),
      body: Row(
        children: [
          // --- Sidebar Widget ---
          WhatsAppSidebar(),

          VerticalDivider(
              width: 1, thickness: 1, color: Theme.of(context).dividerColor),

          // --- Chat List Panel Widget ---
          Expanded(
            child: ChatListPanel(),
          ),

          Expanded(
            flex: 3, // Adjust flex factor as needed
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                  child: Text('Chat Detail Area',
                      style: TextStyle(color: Colors.grey[500]))),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Sidebar Widget ---
class WhatsAppSidebar extends StatelessWidget {
  const WhatsAppSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        Theme.of(context).iconTheme.color ?? Colors.grey[400]!;
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      width: 75,
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Icons Section
          Column(
            children: [
              _SidebarIcon(
                icon: Icons.chat_bubble_outline_rounded,
                tooltip: 'Chats',
                color: iconColor,
                onPressed: () => print('Chats Tapped'),
              ),
              SizedBox(height: 20),
              _SidebarIcon(
                icon: Icons.circle_outlined,
                tooltip: 'Status',
                color: iconColor,
                onPressed: () => print('Status Tapped'),
              ),
              SizedBox(height: 20),
              _SidebarIcon(
                icon: Icons.campaign_outlined,
                tooltip: 'Channels',
                color: iconColor,
                onPressed: () => print('Channels Tapped'),
              ),
              SizedBox(height: 20),
              _SidebarIcon(
                icon: Icons.archive_outlined,
                tooltip: 'Archived',
                color: iconColor,
                onPressed: () => print('Archived Tapped'),
              ),
            ],
          ),

          // Bottom Icons Section
          Column(
            children: [
              _SidebarIcon(
                icon: Icons.star_border_outlined,
                tooltip: 'Starred Messages',
                color: iconColor,
                onPressed: () => print('Starred Tapped'),
              ),
              SizedBox(height: 20),
              _SidebarIcon(
                icon: Icons.settings_outlined,
                tooltip: 'Settings',
                color: iconColor,
                onPressed: () => print('Settings Tapped'),
              ),
              SizedBox(height: 25),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[700],
                child: Icon(Icons.person, size: 20, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color;

  const _SidebarIcon({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 24,
      color: color ?? Theme.of(context).iconTheme.color,
      tooltip: tooltip,
      onPressed: onPressed,
      splashRadius: 20,
      hoverColor: Colors.white.withOpacity(0.1),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
    );
  }
}

class ChatListPanel extends StatelessWidget {
  const ChatListPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = Theme.of(context).colorScheme.surface;
    final Color onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    final Color hintColor =
        Theme.of(context).inputDecorationTheme.hintStyle?.color ??
            Colors.grey[500]!;
    final Color iconColor =
        Theme.of(context).iconTheme.color ?? Colors.grey[400]!;
    final Color panelBackgroundColor =
        Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: panelBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 15.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chats',
                  style: TextStyle(
                    color: onSurfaceColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit_square, color: iconColor),
                      tooltip: 'New Chat',
                      onPressed: () {},
                      splashRadius: 20,
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.filter_list, color: iconColor),
                      tooltip: 'Filter chats',
                      onPressed: () {},
                      splashRadius: 20,
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                style: TextStyle(color: onSurfaceColor),
                decoration: InputDecoration(
                  hintText: 'Search or start a new chat',
                  hintStyle: TextStyle(color: hintColor, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: hintColor, size: 20),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
          ),

          // Chat List View
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5.0),
              itemCount: dummyChats.length,
              itemBuilder: (context, index) {
                final chat = dummyChats[index];
                return _ChatItem(chat: chat);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final Chat chat;

  const _ChatItem({required this.chat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color listTextColor =
        Theme.of(context).listTileTheme.textColor ?? Colors.grey[200]!;
    final Color subtitleColor = Colors.grey[500]!;
    final Color timestampColor = Colors.grey[500]!;
    final Color dividerColor = Theme.of(context).dividerColor;
    final Color unreadBadgeTextColor =
        Theme.of(context).brightness == Brightness.dark
            ? Color(0xFF111B21)
            : Colors.white;

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[700],
              child: Icon(
                chat.isGroup ? Icons.group_rounded : Icons.person_rounded,
                color: Colors.white70,
                size: 30,
              )),
          title: Text(
            chat.name,
            style: TextStyle(
              color: listTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            chat.lastMessage,
            style: TextStyle(color: subtitleColor, fontSize: 14),
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
                      ? primaryColor
                      : timestampColor, // Green if unread
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chat.isPinned)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.push_pin_rounded,
                          size: 18, color: subtitleColor),
                    ),
                  Visibility(
                    visible: chat.unreadCount > 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: primaryColor, // Green background
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: TextStyle(
                          color: unreadBadgeTextColor,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            // Handle chat item tap - e.g., navigate to chat screen
            print('Tapped on ${chat.name}');
          },
        ),
        Divider(
            indent: 85,
            height: 0.5,
            thickness: 0.5,
            color: dividerColor), // Indented divider
      ],
    );
  }
}
