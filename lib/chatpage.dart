import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final String username;
  const ChatPage({required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();

  void sendMessage(String text) {
    setState(() {
      messages.add({"type": "text", "content": text});
    });
    messageController.clear();
  }

  Future<void> sendImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        messages.add({"type": "image", "content": File(picked.path)});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (_, index) {
              final msg = messages[index];
              return msg['type'] == 'text'
                  ? ListTile(title: Text(msg['content']))
                  : Image.file(msg['content'], height: 150);
            },
          ),
        ),
        Row(
          children: [
            IconButton(onPressed: sendImage, icon: Icon(Icons.image)),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(hintText: "Type message..."),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => sendMessage(messageController.text),
            ),
          ],
        )
      ],
    );
  }
}
