import 'package:flutter/material.dart';

class NewChat extends StatelessWidget {
  const NewChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChatListScreen());
  }
}

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chatList = [
    {"name": "Reenu (You)", "message": "Message yourself"},
    {"name": "Ruhaan", "message": "How do choices affect our lives?? T..."},
    {"name": "Anjani Kota", "message": "Well yes, I do!"},
    {"name": "Niha", "message": "Hey there! I am using WhatsApp."},
    {"name": "Inna", "message": "Hey there! I am using WhatsApp."},
    {"name": "ABC XEROX", "message": "Hey there! I am using WhatsApp."},
    {"name": "ABD-ullah", "message": ":("},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat'),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 500,
            child: Container(
constraints: BoxConstraints(maxHeight: 400),
              padding: EdgeInsets.all(16),              child: ListTile(
                leading: CircleAvatar(child: Text(chatList[index]['name']![0])),
                title: Text(chatList[index]['name']!),
                subtitle: Text(chatList[index]['message']!),
                onTap: () {
                  // Handle chat open
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
