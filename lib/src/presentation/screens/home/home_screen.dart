import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/animations/animations.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header + Notification
          AppAnimations.fadeIn(child: _NotificationHeader(controller: c)),

          const SizedBox(height: 16),

          // Greeting Card
          AppAnimations.slideUp(
            child: _GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    AppAnimations.scaleIn(
                      child: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.handshake_outlined, color: theme.colorScheme.primary),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('welcome'.tr, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text(
                            'This is a clean starter with MVVM + GetX + Dio + Hive.',
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(.7)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick Stats
          AppAnimations.slideUp(
            child: Row(
              children: const [
                Expanded(child: _StatTile(title: 'Tasks', value: '128', icon: Icons.check_circle_outline)),
                SizedBox(width: 12),
                Expanded(child: _StatTile(title: 'Projects', value: '08', icon: Icons.folder_open)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          AppAnimations.slideUp(
            child: Row(
              children: const [
                Expanded(child: _StatTile(title: 'Messages', value: '23', icon: Icons.forum_outlined)),
                SizedBox(width: 12),
                Expanded(child: _StatTile(title: 'Alerts', value: '03', icon: Icons.notifications_active_outlined)),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Quick Actions
          AppAnimations.fadeIn(
            child: Text('Quick actions', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          AppAnimations.slideUp(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _ActionChip(icon: Icons.add_task, label: 'New Task'),
                _ActionChip(icon: Icons.person_add_alt, label: 'Invite'),
                _ActionChip(icon: Icons.upload_file_outlined, label: 'Upload'),
                _ActionChip(icon: Icons.pie_chart_outline, label: 'Report'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationHeader extends StatelessWidget {
  final HomeController controller;
  const _NotificationHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final text = controller.notifications.isNotEmpty
          ? controller.notifications.first
          : 'notifications'.tr;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(.14),
              theme.colorScheme.primary.withOpacity(.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: theme.colorScheme.primary.withOpacity(.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // animated bell
            AppAnimations.scaleIn(
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_active_outlined),
              ),
            ),
            const SizedBox(width: 12),
            // animated text
            Expanded(
              child: AppAnimations.fadeIn(
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withOpacity(.9),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Refresh',
              icon: const Icon(Icons.refresh),
              onPressed: () {
                controller.notifications.shuffle();
                controller.notifications.refresh();
              },
            ),
          ],
        ),
      );
    });
  }
}

class _StatTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatTile({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AppAnimations.scaleIn(
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: theme.colorScheme.onSecondaryContainer),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(title, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppAnimations.fadeIn(
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(label, style: theme.textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft elevated card with subtle border – reusable
class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}
