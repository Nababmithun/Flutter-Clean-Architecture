import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.receipt_long)),
          title: Text('History Item #$i'),
          subtitle: const Text('This is a placeholder row'),
        ),
      ),
    );
  }
}
