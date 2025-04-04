import 'package:flutter/foundation.dart' show immutable;

@immutable
class Chat {
  final String id;
  final String avatarUrl;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted;
  final bool isGroup;

  const Chat({
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
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  const Message({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}
