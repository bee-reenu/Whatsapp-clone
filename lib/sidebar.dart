import 'package:flutter/material.dart';

// --- Sidebar Widget (Stateless) ---
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
          // Top Icons
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
          // Bottom Icons
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

// --- Helper for Sidebar Icons (Stateless) ---
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
