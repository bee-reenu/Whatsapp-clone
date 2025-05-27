import 'package:clone/new_chat.dart';
import 'package:flutter/material.dart';
import 'models.dart';

// --- Chat List Panel Widget ---
class ChatListPanel extends StatelessWidget {
  final List<Chat> chats;
  final String? selectedChatId;
  final ValueChanged<String> onChatSelected;

  const ChatListPanel({
    required this.chats,
    required this.onChatSelected,
    this.selectedChatId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color surfaceColor = theme.colorScheme.surface;
    final Color onSurfaceColor = theme.colorScheme.onSurface;
    final Color hintColor =
        theme.inputDecorationTheme.hintStyle?.color ?? Colors.grey[500]!;
    final Color iconColor = theme.iconTheme.color ?? Colors.grey[400]!;
    final Color panelBackgroundColor = theme.scaffoldBackgroundColor;

    return Container(
      color: panelBackgroundColor,
      child: Column(
        children: [
          // Header Section
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewChat()),
                        );
                      },
                      splashRadius: 20,
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.filter_list, color: iconColor),
                      tooltip: 'Filter chats',
                      onPressed: () {/* TODO */},
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
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
          ),

          // Chat List View
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5.0),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _ChatItem(
                  chat: chat,
                  isSelected: chat.id == selectedChatId,
                  onTap: () => onChatSelected(chat.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Chat Item Widget ---
class _ChatItem extends StatelessWidget {
  final Chat chat;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChatItem({
    required this.chat,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color listTextColor =
        theme.listTileTheme.textColor ?? Colors.grey[200]!;
    final Color subtitleColor = Colors.grey[500]!;
    final Color timestampColor = Colors.grey[500]!;
    final Color dividerColor = theme.dividerColor;
    final Color selectionColor = theme.colorScheme.surface;
    final Color unreadBadgeTextColor =
        theme.brightness == Brightness.dark ? Color(0xFF111B21) : Colors.white;

    return Column(
      children: [
        ListTile(
          tileColor: isSelected ? selectionColor : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[700],
            child: chat.avatarUrl.isEmpty
                ? Icon(
                    chat.isGroup ? Icons.group_rounded : Icons.person_rounded,
                    color: Colors.white70,
                    size: 30,
                  )
                : null,
          ),
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
                  color: chat.unreadCount > 0 && !isSelected
                      ? primaryColor
                      : timestampColor,
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
                    visible: chat.unreadCount > 0 && !isSelected,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: primaryColor,
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
          onTap: onTap,
        ),
        Divider(indent: 85, height: 0.5, thickness: 0.5, color: dividerColor),
      ],
    );
  }
}
