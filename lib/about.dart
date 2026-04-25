import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _SectionHeader(
              title: 'About',
              subtitle: 'Help, settings, recommendations, and app credits.',
              icon: Icons.info_outline,
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.help_outline_rounded,
              title: 'Help',
              subtitle: 'Learn how to add and review your transactions.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.settings_suggest_outlined,
              title: 'Configuration / Settings',
              subtitle: 'Customize currency, notifications, and display options.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Recommendation',
              subtitle: 'Get practical tips to improve savings and budget control.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.workspace_premium_outlined,
              title: 'Credits',
              subtitle: 'Built by TipidBuddy Team with Flutter.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2745),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFA5B4FC)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AboutItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFA5B4FC)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
