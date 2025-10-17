import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/animations/animations.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {"title": "Free Plan", "price": "৳0", "features": ["Basic access", "Limited usage"]},
      {"title": "Pro Plan", "price": "৳499/month", "features": ["Unlimited usage", "Priority support"]},
      {"title": "Enterprise", "price": "Custom", "features": ["Dedicated support", "Custom features"]},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Subscription Plans")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: plans.length,
        itemBuilder: (_, i) {
          final plan = plans[i];
          return AppAnimations.slideUp(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (plan['title'] as String),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (plan['price'] as String),
                      style: TextStyle(fontSize: 18, color: Colors.teal[700]),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate((plan['features'] as List).length, (j) {
                      return Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.teal),
                          const SizedBox(width: 6),
                          Text((plan['features'] as List)[j].toString()),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => Get.snackbar(
                          "Subscribed",
                          "You chose ${(plan['title'] as String)}",
                        ),
                        child: const Text("Choose Plan"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
