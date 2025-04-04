import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

// Import the widgets and data
import 'models.dart';
import 'dummy_data.dart';
import 'sidebar.dart';
import 'chat_list.dart';
import 'chat_details.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF111B21), // Main background
        dividerColor: Colors.white.withOpacity(0.15),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00A884), // WhatsApp green accent
          secondary: Color(0xFF005D4B), // Darker green shade for sent messages
          surface: Color(0xFF202C33), // Appbar, Search bar, received message bg
          onSurface: Colors.grey[300]!, // Text/icons on surface elements
          onBackground: Colors.grey[300]!, // Text/icons on main background
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[300], fontSize: 14.0),
          titleMedium: TextStyle(color: Colors.grey[200], fontSize: 16.0),
          labelSmall: TextStyle(color: Colors.grey[500], fontSize: 11.0),
        ),
        iconTheme: IconThemeData(color: Colors.grey[400]),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.grey[400],
          textColor: Colors.grey[200],
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: Colors.grey[500],
          fillColor: Color(0xFF202C33),
          filled: true,
          // Default border for input fields (used in chat detail)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
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

// --- Main Screen (Stateful) ---
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _selectedChatId;
  // Use copies of the dummy data to allow modification within the state
  final List<Chat> _chats = List<Chat>.from(dummyChatsData);
  final Map<String, List<Message>> _messages = Map<String, List<Message>>.from(
      dummyMessagesData
          .map((key, value) => MapEntry(key, List<Message>.from(value))));

  void _onChatSelected(String chatId) {
    setState(() {
      _selectedChatId = chatId;
      // Find the chat index to update unread count
      final chatIndex = _chats.indexWhere((c) => c.id == chatId);
      if (chatIndex != -1) {
        // Create a new Chat object with unreadCount = 0 if using immutable Chat
        // Or directly modify if Chat fields are not final:
        // _chats[chatIndex].unreadCount = 0;
        // For immutable approach (replace line above):
        _chats[chatIndex] = _chats[chatIndex].copyWith(unreadCount: 0);
      }
    });
  }

  void _sendMessage(String chatId, String text) {
    if (text.trim().isEmpty) return;

    final newMessage = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
    );

    setState(() {
      // Add message
      _messages.putIfAbsent(chatId, () => []).add(newMessage);

      // Update chat list item
      final chatIndex = _chats.indexWhere((c) => c.id == chatId);
      if (chatIndex != -1) {
        // If using immutable Chat:
        final originalChat = _chats[chatIndex];
        _chats[chatIndex] = originalChat.copyWith(
          lastMessage: text.trim(),
          timestamp: DateFormat.jm().format(newMessage.timestamp),
        );
        // Move chat to top (optional)
        // final updatedChat = _chats.removeAt(chatIndex);
        // _chats.insert(0, updatedChat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Chat? selectedChat = _selectedChatId == null
        ? null
        : _chats.firstWhere((chat) => chat.id == _selectedChatId,
            orElse: () => _chats.first); // Fallback in case ID mismatch

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          WhatsAppSidebar(),

          // Chat List Panel
          Container(
            width: 350, // Adjust width as needed
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                    color: Theme.of(context).dividerColor, width: 0.5),
              ),
            ),
            child: ChatListPanel(
              chats: _chats,
              selectedChatId: _selectedChatId,
              onChatSelected: _onChatSelected,
            ),
          ),

          // Chat Detail Panel
          Expanded(
            child: _selectedChatId != null && selectedChat != null
                ? ChatDetailPanel(
                    chat: selectedChat,
                    messages: _messages[_selectedChatId] ?? [],
                    onSendMessage: (text) =>
                        _sendMessage(_selectedChatId!, text),
                  )
                : Container(
                    // Placeholder View
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.message_rounded,
                              size: 80, color: Colors.grey[700]),
                          SizedBox(height: 20),
                          Text(
                            'WhatsApp Clone',
                            style: TextStyle(
                                fontSize: 24, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Select a chat to start messaging',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
