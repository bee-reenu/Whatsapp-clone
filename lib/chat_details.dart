import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'models.dart';

// --- Chat Detail Panel Widget ---
class ChatDetailPanel extends StatefulWidget {
  final Chat chat;
  final List<Message> messages;
  final ValueChanged<String> onSendMessage;

  const ChatDetailPanel({
    required this.chat,
    required this.messages,
    required this.onSendMessage,
    Key? key,
  }) : super(key: key);

  @override
  _ChatDetailPanelState createState() => _ChatDetailPanelState();
}

class _ChatDetailPanelState extends State<ChatDetailPanel> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(ChatDetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chat.id != widget.chat.id ||
        oldWidget.messages.length < widget.messages.length) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollToBottom(animate: true));
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSendPressed() {
    if (_messageController.text.trim().isNotEmpty) {
      widget.onSendMessage(_messageController.text.trim());
      _messageController.clear();
    }
  }

  void _scrollToBottom({bool animate = false}) {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      try {
        if (animate) {
          _scrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(position);
        }
      } catch (e) {
        // Handle potential errors during scroll, e.g., if disposed
        print("Error scrolling: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatBackground = Container(color: Color(0xFF0b141a));

    return Column(
      children: [
        // Chat Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          color: theme.colorScheme.surface,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[700],
                child: widget.chat.avatarUrl.isEmpty
                    ? Icon(
                        widget.chat.isGroup
                            ? Icons.group_rounded
                            : Icons.person_rounded,
                        color: Colors.white70,
                        size: 24,
                      )
                    : null,
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chat.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.chat.isGroup
                          ? 'Tap here for group info'
                          : 'online',
                      style:
                          theme.textTheme.labelSmall?.copyWith(fontSize: 12.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.videocam_outlined),
                  tooltip: 'Video call',
                  onPressed: () {},
                  splashRadius: 20),
              IconButton(
                  icon: Icon(Icons.call_outlined),
                  tooltip: 'Audio call',
                  onPressed: () {},
                  splashRadius: 20),
              IconButton(
                  icon: Icon(Icons.more_vert),
                  tooltip: 'More options',
                  onPressed: () {},
                  splashRadius: 20),
            ],
          ),
        ),

        // Message List
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: chatBackground),
              ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  final message = widget.messages[index];
                  final isMe = message.isMe;
                  final alignment =
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                  final color =
                      isMe ? Color(0xFF005D4B) : theme.colorScheme.surface;
                  final textColor = theme.colorScheme.onSurface;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: alignment,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.65),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                              bottomLeft: isMe
                                  ? Radius.circular(12.0)
                                  : Radius.circular(0.0),
                              bottomRight: isMe
                                  ? Radius.circular(0.0)
                                  : Radius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  message.text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: textColor,
                                      fontSize: 14.5,
                                      height: 1.3),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                DateFormat.jm().format(message.timestamp),
                                style: theme.textTheme.labelSmall?.copyWith(
                                    color: textColor.withOpacity(0.7)),
                              ),
                              if (isMe)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(Icons.done_all,
                                      size: 16.0, color: Colors.blue[300]),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Message Input Area
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border(
                top: BorderSide(
                    color: theme.dividerColor.withOpacity(0.5), width: 0.5)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  tooltip: 'Emoji',
                  onPressed: () {},
                  color: theme.iconTheme.color,
                ),
                IconButton(
                  icon: Icon(Icons.attach_file_outlined),
                  tooltip: 'Attach file',
                  onPressed: () {},
                  color: theme.iconTheme.color,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurface),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(
                          color: theme.inputDecorationTheme.hintStyle?.color),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: theme.inputDecorationTheme.fillColor ??
                          theme.colorScheme.surface,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _handleSendPressed(),
                    minLines: 1,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  tooltip: 'Send message',
                  onPressed: _handleSendPressed,
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
