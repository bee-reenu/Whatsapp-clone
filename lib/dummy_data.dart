import 'models.dart';

final List<Chat> dummyChatsData = [
  Chat(
    id: 'chat1',
    name: 'Reenu (You)',
    lastMessage: 'Hello',
    timestamp: '06:01 PM',
    isPinned: true,
  ),
  Chat(
    id: 'chat2',
    name: 'Friends forever lol',
    lastMessage: 'Riya: Thank you guys',
    timestamp: '01:36 PM',
    unreadCount: 6,
    isPinned: true,
    isGroup: true,
  ),
  Chat(
    id: 'chat3',
    name: 'ISE 2025',
    lastMessage: 'Gururaj (PO): Policy Bazaar team wo...',
    timestamp: '01:19 PM',
    unreadCount: 3,
    isGroup: true,
  ),
  Chat(
    id: 'chat4',
    name: 'Daddy',
    lastMessage: 'Waiting for this message...',
    timestamp: '12:28 PM',
    unreadCount: 1,
  ),
  Chat(
    id: 'chat5',
    name: '+91 79831 10682',
    lastMessage: '+91 79831 10682 turned off disappeari...',
    timestamp: '12:27 PM',
    unreadCount: 1,
  ),
  Chat(
    id: 'chat6',
    name: 'Riya',
    lastMessage: 'Hiiii guys suppp',
    timestamp: '12:26 PM',
  ),
  Chat(
    id: 'chat2',
    name: 'Friends forever lol',
    lastMessage: 'Riya: Thank you guys',
    timestamp: '01:36 PM',
    unreadCount: 6,
    isPinned: true,
    isGroup: true,
  ),
  Chat(
    id: 'chat3',
    name: 'ISE 2025',
    lastMessage: 'Gururaj (PO): Policy Bazaar team wo...',
    timestamp: '01:19 PM',
    unreadCount: 3,
    isGroup: true,
  ),
  Chat(
    id: 'chat4',
    name: 'Daddy',
    lastMessage: 'Waiting for this message...',
    timestamp: '12:28 PM',
    unreadCount: 1,
  ),
  Chat(
    id: 'chat5',
    name: '+91 79831 10682',
    lastMessage: '+91 79831 10682 turned off disappeari...',
    timestamp: '12:27 PM',
    unreadCount: 1,
  ),
];

// Messages Data (Map keyed by chat ID)
final Map<String, List<Message>> dummyMessagesData = {
  // Renamed
  'chat1': [
    Message(
        id: 'm1_1',
        text: 'Okay, checking it now.',
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
        isMe: false),
    Message(
        id: 'm1_2',
        text: '2021 - AICTE Activity Point Progra...',
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
        isMe: true),
  ],
  'chat2': [
    Message(
        id: 'm2_1',
        text: 'Please submit the reports by EOD.',
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
        isMe: false),
    Message(
        id: 'm2_2',
        text: 'Muskan: Thank you sir',
        timestamp: DateTime.now().subtract(Duration(hours: 4)),
        isMe: false),
  ],
  'chat3': [
    Message(
        id: 'm3_1',
        text: 'Gururaj (PO): Policy Bazaar team working on integration.',
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
        isMe: false),
  ],
  'chat4': [
    Message(
        id: 'm4_1',
        text: 'Call me back when you are free.',
        timestamp: DateTime.now().subtract(Duration(hours: 6)),
        isMe: false),
    Message(
        id: 'm4_2',
        text: 'Waiting for this message...',
        timestamp: DateTime.now().subtract(Duration(hours: 5, minutes: 50)),
        isMe: true),
  ],
  'chat5': [
    Message(
        id: 'm5_1',
        text: '+91 79831 10682 turned off disappearing messages.',
        timestamp: DateTime.now().subtract(Duration(hours: 6)),
        isMe: false),
  ],
  'chat6': [
    Message(
        id: 'm6_1',
        text: 'Did you record it?',
        timestamp: DateTime.now().subtract(Duration(hours: 7)),
        isMe: false),
    Message(
        id: 'm6_2',
        text: '✓✓ Kab record kya woh',
        timestamp: DateTime.now().subtract(Duration(hours: 6, minutes: 50)),
        isMe: true),
  ],
};
