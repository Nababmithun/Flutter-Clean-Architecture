import 'package:flutter/material.dart';

import '../../../core/animations/animations.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      12,
          (i) => HistoryItem(
        title: 'History Item #${i + 1}',
        subtitle: 'This is a placeholder row with smooth animation',
        leading: Icons.receipt_long,
        meta: '${(i + 1) * 3}m ago',
      ),
    );

    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final item = items[i];
          return _AnimatedHistoryTile(item: item, index: i);
        },
      ),
    );
  }
}

class _AnimatedHistoryTile extends StatelessWidget {
  final HistoryItem item;
  final int index;
  const _AnimatedHistoryTile({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    // staggered feel using slightly increasing duration
    final dur = Duration(milliseconds: 250 + (index * 40));

    return AppAnimations.slideUp(
      duration: dur,
      child: AppAnimations.fadeIn(
        duration: dur,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.leading, color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(item.subtitle),
            trailing: Text(item.meta, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class HistoryItem {
  final String title;
  final String subtitle;
  final String meta;
  final IconData leading;
  HistoryItem({required this.title, required this.subtitle, required this.meta, required this.leading});
}
