import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2A44),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Avatar with edit badge
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0E0E0),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/profile.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1F2A44),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Merdan Annaýew",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2A44),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                "+993 64 796803",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 24),
            _ProfileMenuTile(
              icon: Icons.person_outline,
              label: "Profili sazlamak",
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.notifications_none,
              label: "Bildirimler",
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.settings_outlined,
              label: "Sazlamalar",
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.help_outline,
              label: "Admin hyzmat",
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.shield_outlined,
              label: "Ulanyjy ylalaşygy",
              onTap: () {},
            ),
            _ProfileMenuTile(
              icon: Icons.logout,
              label: "Ulgamdan çykmak",
              onTap: () {},
              showDivider: false,
              showChevron: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;
  final bool showChevron;

  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF1F2A44), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ),
                if (showChevron)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade200,
            indent: 20,
            endIndent: 20,
          ),
      ],
    );
  }
}
