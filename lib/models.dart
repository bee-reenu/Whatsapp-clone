import 'package:flutter/foundation.dart' show immutable;

@immutable // Marks the class and subclasses as immutable
class Chat {
  final String id; // Unique ID for each chat
  final String avatarUrl;
  final String name;
  final String lastMessage; // Keep non-final if you update directly, or create new object on update
  final String timestamp;   // Keep non-final if you update directly, or create new object on update
  final int unreadCount; // Keep non-final if you update directly, or create new object on update
  final bool isPinned;
  final bool isMuted;
  final bool isGroup;

  const Chat({ // Use const constructor for immutable class
    required this.id,
    this.avatarUrl = '',
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isMuted = false,
    this.isGroup = false,
  });

  // Optional: Method to create a copy with updated values (if keeping class immutable)
  Chat copyWith({
    String? id,
    String? avatarUrl,
    String? name,
    String? lastMessage,
    String? timestamp,
    int? unreadCount,
    bool? isPinned,
    bool? isMuted,
    bool? isGroup,
  }) {
    return Chat(
      id: id ?? this.id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      isGroup: isGroup ?? this.isGroup,
    );
  }
}

@immutable
class Message {
  final String id; // Unique ID for each message
  final String text;
  final DateTime timestamp;
  final bool isMe; // True if sent by the current user

  const Message({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}