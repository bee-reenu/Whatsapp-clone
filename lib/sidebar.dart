import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WhatsAppSideBar());
  }
}

class WhatsAppSideBar extends StatelessWidget {
  const WhatsAppSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 75,
        color: Color(0xFF111B21),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- Top Section Icons ---
            Column(
              children: [
                // Placeholder for WhatsApp-like logo
                _SidebarIcon(
                  icon: Icons.chat_bubble_outline_rounded,
                  tooltip: 'Chats',
                  onPressed: () => print('Chats Tapped'),
                ),
                SizedBox(height: 20),
                _SidebarIcon(
                  // Placeholder for Status/Updates (using circle)
                  icon: Icons.circle_outlined, // Or Icons.data_usage
                  tooltip: 'Status',
                  onPressed: () => print('Status Tapped'),
                ),
                SizedBox(height: 20),
                _SidebarIcon(
                  // Placeholder for Channels (using campaign icon)
                  icon: Icons.campaign_outlined,
                  tooltip: 'Channels',
                  onPressed: () => print('Channels Tapped'),
                ),
                SizedBox(height: 20),
                _SidebarIcon(
                  icon: Icons.archive_outlined,
                  tooltip: 'Archived',
                  onPressed: () => print('Archived Tapped'),
                ),
              ],
            ),

            // --- Bottom Section Icons ---
            Column(
              children: [
                _SidebarIcon(
                  icon: Icons.star_border_outlined,
                  tooltip: 'Starred Messages',
                  onPressed: () => print('Starred Tapped'),
                ),
                SizedBox(height: 20),
                _SidebarIcon(
                  icon: Icons.settings_outlined,
                  tooltip: 'Settings',
                  onPressed: () => print('Settings Tapped'),
                ),
                SizedBox(height: 25),
                // --- Profile Picture ---
                CircleAvatar(
                  radius: 18, // Adjust size as needed
                  backgroundColor: Colors.grey[600], // Placeholder color
                  // Replace with NetworkImage, AssetImage, or other source
                  child: Icon(Icons.person, size: 20, color: Colors.white),
                  // You can add an InkWell or GestureDetector around this
                  // for tap functionality if needed.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color; // Optional color override

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
      iconSize: 24, // Standard icon size
      color: color ?? Colors.grey[400], // Default color if not provided
      tooltip: tooltip, // Shows text on hover (Desktop/Web)
      onPressed: onPressed,
      splashRadius: 20, // Size of the ripple effect
      hoverColor: Colors.white.withOpacity(0.1), // Subtle hover effect
      padding: EdgeInsets.zero, // Remove default padding
      constraints:
          BoxConstraints(), // Remove default constraints for tighter layout
    );
  }
}
